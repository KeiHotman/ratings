class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :grade
      t.integer :department

      t.timestamps null: false
    end
  end
end
