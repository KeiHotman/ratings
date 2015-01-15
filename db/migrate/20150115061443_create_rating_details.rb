class CreateRatingDetails < ActiveRecord::Migration
  def change
    create_table :rating_details do |t|
      t.references :rating, index: true
      t.references :user, index: true
      t.references :item, index: true
      t.references :item_detail, index: true
      t.boolean :negative_cause

      t.timestamps null: false
    end
    add_foreign_key :rating_details, :users
    add_foreign_key :rating_details, :ratings
    add_foreign_key :rating_details, :items
    add_foreign_key :rating_details, :item_details
  end
end
