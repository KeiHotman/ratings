previous_experiment_path = "#{Rails.root}/db/seeds/previous_experiment"
items    = JSON.parse(File.read("#{previous_experiment_path}/items.json"))
subjects = JSON.parse(File.read("#{previous_experiment_path}/subjects.json"))
ratings  = JSON.parse(File.read("#{previous_experiment_path}/ratings.json"))
opinions = JSON.parse(File.read("#{previous_experiment_path}/opinions.json"))
user_keys = {'101' => 'F2', '91' => 'I2', '81' => 'K2', '71' => 'K1', '61' => 'I1', '51' => 'K2', '41' => 'M2', '31' => 'H1', '21' => 'Y1', '11' => 'Y2'}

# load ratings
ratings.each do |rating|
  # get user
  user_name = user_keys[rating['user_id']]
  user = User.find_or_initialize_by(name: user_name, email: "#{user_name.downcase}@example.com")
  unless user.persisted?
    user.password = 'password'
    user.save
  end

  # get item
  item_json = items.find{|i| i['id'] == rating['item_id']}
  next unless item_json
  item = Item.find_by(name: item_json['name'], year: item_json['year']) || Item.find_by(name: item_json['name'])
  item.update(assign: item_json['provided_by']) unless item.assign rescue puts item_json

  # create rating
  Rating.create(user: user, item: item, score: rating['score'], taken: true, prediction: false)
end

puts "FINISH: #{ratings.size} ratings"

# load negative ratings
subjects.each do |s|
  ItemDetail.create(name: s["title"])
end

opinions.each do |o|
  user_id, item_id, subject_id = o["user_id"], o["item_id"], o["subject_id"]
  user_name = user_keys[o['user_id']]
  item_json = items.find{|i| i['id'] == o['item_id']}
  user = User.find_by(name: user_name)
  item = Item.find_by(name: item_json['name'], year: item_json['year'])
  rating = Rating.find_by(user: user, item: item)
  subject = subjects.find{|s| s["id"] == subject_id }
  item_detail = ItemDetail.find_by(name: subject["title"])
  RatingDetail.create!(user: user, item: item, rating: rating, item_detail: item_detail, negative_cause: true)
end

puts "FINISH: #{opinions.size} negative ratings"
