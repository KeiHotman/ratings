previous_ratings = JSON.parse(File.read("#{Rails.root}/db/seeds/previous_ratings.json"))
previous_items = JSON.parse(File.read("#{Rails.root}/db/seeds/previous_items.json"))
user_keys = {'101' => 'fujita', '91' => 'imayoshi', '81' => 'kawaguchi', '71' => 'katayama', '61' => 'inoue', '51' => 'kishimoto', '41' => 'matsumoto', '31' => 'hara', '21' => 'yoshida', '11' => 'yashiki'}

previous_ratings.each do |rating|
  user_name = user_keys[rating['user_id'].to_s]
  user = User.find_or_initialize_by(name: user_name, email: "#{user_name}@example.com")
  unless user.persisted?
    user.password = 'password'
    user.save
  end

  item_name = previous_items[rating['item_id'].to_s]
  if item = Item.find_by(name: item_name)
    Rating.create(user: user, item: item, score: rating['score'].to_f, taken: true, prediction: false)
  else
    puts "ERROR: #{rating}"
  end
end

puts "FINISH: #{previous_ratings.size} ratings"
