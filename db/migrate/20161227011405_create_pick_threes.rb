class CreatePickThrees < ActiveRecord::Migration[5.0]
  def change
    create_table :pick_threes do |t|
      t.references :drawing_time, foreign_key: true
      t.integer :first_ball
      t.integer :second_ball
      t.integer :third_ball
      t.date :drawing_date

      t.timestamps
    end
  end
end
