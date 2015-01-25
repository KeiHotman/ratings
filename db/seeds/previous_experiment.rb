previous_experiment_path = "#{Rails.root}/db/seeds/previous_experiment"
items    = JSON.parse(File.read("#{previous_experiment_path}/items.json"))
subjects = JSON.parse(File.read("#{previous_experiment_path}/subjects.json"))
ratings  = JSON.parse(File.read("#{previous_experiment_path}/ratings.json"))
opinions = JSON.parse(File.read("#{previous_experiment_path}/opinions.json"))
user_keys = {'101' => 'F2', '91' => 'I2', '81' => 'K2', '71' => 'K1', '61' => 'I1', '51' => 'K2', '41' => 'M2', '31' => 'H1', '21' => 'Y1', '11' => 'Y2'}

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
