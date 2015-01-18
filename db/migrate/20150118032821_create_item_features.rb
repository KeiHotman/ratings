class CreateItemFeatures < ActiveRecord::Migration
  def change
    create_table :item_features do |t|
      t.references :item, index: true
      t.string :name
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :item_features, :items
  end
end
