class AddIndexToPickThree < ActiveRecord::Migration[5.0]
  def change
    add_index :pick_threes, [:drawing_date, :drawing_time_id], unique: true
  end
end
