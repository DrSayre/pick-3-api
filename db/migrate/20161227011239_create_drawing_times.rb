class CreateDrawingTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :drawing_times do |t|
      t.string :name

      t.timestamps
    end
  end
end
