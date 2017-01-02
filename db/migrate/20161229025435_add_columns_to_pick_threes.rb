class AddColumnsToPickThrees < ActiveRecord::Migration[5.0]
  def change
    add_column :pick_threes, :front_pair, :integer
    add_column :pick_threes, :back_pair, :integer
    add_column :pick_threes, :split_pair, :integer
    add_column :pick_threes, :numbers, :integer
    PickThree.all.each do |pick_three|
      pick_three.update( front_pair: pick_three.first_ball * 10 + pick_three.second_ball,
                         back_pair: pick_three.second_ball * 10 + pick_three.third_ball,
                         split_pair: pick_three.first_ball * 10 + pick_three.third_ball,
                         numbers: pick_three.first_ball * 100 + pick_three.second_ball * 10 + pick_three.third_ball )
    end
  end
end
