class AddColumnsToItem < ActiveRecord::Migration
  def change
    add_column :items, :year, :integer
    add_column :items, :english_name, :string
    add_column :items, :term, :string
    add_column :items, :credit_num, :integer
    add_column :items, :credit_requirement, :string
    add_column :items, :assign, :string
  end
end
