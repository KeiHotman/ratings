class CreateUsersSimilarities < ActiveRecord::Migration
  def change
    create_table :users_similarities do |t|
      t.references :user, index: true
      t.integer :target_id
      t.float :value

      t.timestamps null: false
    end
    add_foreign_key :users_similarities, :users
  end
end
