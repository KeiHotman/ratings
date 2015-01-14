class AddPredictionAndTakenToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :prediction, :boolean, default: false
    add_column :ratings, :taken, :boolean, default: false
  end
end
