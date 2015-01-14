# encoding: utf-8

namespace :calc do
  desc "Calculation all users' similarities"
  task similarities: :environment do
    start_at = Time.now
    subject_users = User.all
    target_users = User.all

    subject_users.each do |subject_user|
      target_users.each do |target_user|
        next if subject_user == target_user

        # ユーザ間類似度を検索、なければ登録
        similarity = UsersSimilarity.find_or_create_by!(user: subject_user, target: target_user)

        # "両ユーザが評価したアイテム"と平均値を取得
        both_rated_items       = subject_user.rated_items_in(target_user.rated_items)
        subject_rating_average = subject_user.ratings.where(item: both_rated_items).average(:score)
        target_rating_average  = target_user.ratings.where(item: both_rated_items).average(:score)

        # "両ユーザが評価したアイテム"の評価値偏差の積と自乗の総和の初期化
        both_deviation_products_sum  = 0
        subject_deviation_square_sum = 0
        target_deviation_square_sum  = 0

        # "両ユーザが評価したアイテム"の評価値偏差の積と自乗の総和"を取得
        both_rated_items.each do |item|
          # "対象アイテムへの両ユーザの評価値"を取得
          subject_user_rating = subject_user.ratings.find_by(item: item)
          target_user_rating  = target_user.ratings.find_by(item: item)

          # "対象アイテムへの両ユーザの評価値"の偏差を取得
          subject_rating_deviation = subject_user_rating.score - subject_rating_average
          target_rating_deviation  = target_user_rating.score  - target_rating_average

          # "両ユーザが評価したアイテムの評価値偏差の積と自乗の総和"に"対象アイテムへの両ユーザの評価値の偏差"の積と自乗を加える
          both_deviation_products_sum  += subject_rating_deviation * target_rating_deviation
          subject_deviation_square_sum += subject_rating_deviation ** 2
          target_deviation_square_sum  += target_rating_deviation  ** 2
        end

        # ユーザ間類似度として両ユーザが評価したアイテムの評価値偏差の積の総和をそれぞれの自乗の総和で割る
        similarity.value = both_deviation_products_sum / (Math.sqrt(subject_deviation_square_sum) * Math.sqrt(target_deviation_square_sum))
        similarity.value = 0 if similarity.value.nan? # ユーザ間類似度がNaNの時、0（相関なし）
        similarity.rated_items_num = both_rated_items.size # "両ユーザが評価したアイテム"数を保存
        similarity.save
      end
    end

    puts "SUBJECT USER: #{subject_users.size}"
    puts "TARGET USER: #{target_users.size}"
    puts "TIME: #{Time.now - start_at} sec"
  end

  task predictions: :environment do
    start_at = Time.now
    users = User.all
    items = Item.all

    users.each do |user|
      # "類似ユーザ"を取得
      similar_users = User.joins(:targeted_similarities).merge(UsersSimilarity.where(user: user).where("value >= 0.7").order('value desc').limit(2))

      # 全アイテムに対する予測評価値の算出
      items.each do |item|
        # 対象ユーザの対象アイテムにおける評価値を検索、なければ生成
        rating = Rating.find_or_initialize_by(user: user, item: item, taken: true)
        next if (!rating.prediction && rating.persisted?) # 評価値計算済みの場合は省略

        # "類似ユーザ評価値偏差・類似度積和"と"総類似度"
        similarity_deviation_products_sum = 0
        total_similarity                  = 0

        # 各類似ユーザの対象アイテムの評価値を予測評価値に反映
        similar_users.each do |similar_user|
          # "対象ユーザと類似ユーザ間の類似度"と"類似ユーザの対象アイテムの評価値"を取得
          similarity = UsersSimilarity.find_by(user: user, target: similar_user)
          similars_rating = Rating.find_by(user: similar_user, item: item, taken: true)

          # "対象ユーザと類似ユーザ間の類似度"が存在する時
          if similars_rating
            # "対象ユーザと類似ユーザ間の類似度"と"類似ユーザの対象アイテムの評価値偏差"の積を"類似ユーザ評価値偏差・類似度積和"に加える
            similarity_deviation_products_sum += similarity.value * (similars_rating.score - similar_user.ratings.average(:score))

            # "総類似度"に"対象ユーザと類似ユーザ間の類似度"を加える
            total_similarity += similarity.value
          end
        end
        begin
          # 予測評価値として対象ユーザの評価値平均に"類似ユーザ評価値偏差・類似度積和"を"総類似度"で割った予測偏差を加える
          prediction = user.ratings.average(:score) + similarity_deviation_products_sum / total_similarity
          rating.assign_attributes(score: prediction, prediction: true)
          rating.save
        rescue => e
          puts "Error: user: #{user.name}, item: #{item.name}"
          puts e.message
        end
      end
    end
    puts "USER: #{users.size}"
    puts "ITEM: #{items.size}"
    puts "TIME: #{Time.now - start_at} sec"
  end
end
