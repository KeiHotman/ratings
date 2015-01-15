class CreateItemDetails < ActiveRecord::Migration
  def change
    create_table :item_details do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
