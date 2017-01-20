class AddFieldsToBoxSingle < ActiveRecord::Migration[5.0]
  def change
    add_column :box_singles, :drawing_time_id, :integer
    add_column :box_singles, :drawing_date, :date
    add_column :box_doubles, :drawing_time_id, :integer
    add_column :box_doubles, :drawing_date, :date
  end
end
