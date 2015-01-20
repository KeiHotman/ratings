class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i(rating rating_details)
  before_action :set_item, only: %i(show rating rating_details)

  def index
    respond_to do |format|
      format.html { @items = user_signed_in? ? Item.currently_on(current_user) : Item.all }
      format.js   { @items = Item.refine(params[:grade], params[:department]) }
    end
  end

  def show
    if current_user
      @rating = Rating.find_by(item: @item, user: current_user)

      # 詳細評価の読み込み
      @existing_rating_details = RatingDetail.between(@item, current_user)
      @unrated_item_details = ItemDetail.id_not_in(@existing_rating_details.pluck(:item_detail_id))
      @item.build_rating_details_from_item_details(@unrated_item_details)
    end
  end

  # POST /items/1/rating
  def rating
    @rating = Rating.find_or_initialize_by(item: @item, user: current_user)
    @rating.assign_attributes(score: params[:score], taken: true)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @item, notice: '評価が登録されました。' }
        format.js
      else
        format.html { redirect_to @item, alert: '評価の登録に失敗しました。' }
        format.js
      end
    end
  end

  # PATCH /items/1/rating_details
  def rating_details
    @rating = Rating.find_by(item: @item, user: current_user)

    respond_to do |format|
      if @item.update(rating_details_params)
        format.html { redirect_to @item, notice: '詳細な評価が登録されました。' }
        format.js
      else
        format.html { redirect_to @item, alert: '詳細な評価の登録に失敗しました。' }
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def rating_details_params
      p = params.require(:item).permit(rating_details_attributes: %i(id item_detail_id negative_cause _destroy))

      # 各RatingDetailにItemとRatingの主キーを登録する
      supplement_params = { item_id: @item.id, rating_id: @rating.id, user: current_user }
      supplemented_params = p[:rating_details_attributes].map{|k, v| [k, v.merge(supplement_params)]}.to_h

      { rating_details_attributes: supplemented_params }
    end
end
