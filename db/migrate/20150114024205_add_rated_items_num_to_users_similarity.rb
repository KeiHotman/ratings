class AddRatedItemsNumToUsersSimilarity < ActiveRecord::Migration
  def change
    add_column :users_similarities, :rated_items_num, :integer, default: 0
  end
end
