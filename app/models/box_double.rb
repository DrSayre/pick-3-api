class BoxDouble < ApplicationRecord
  def self.update_last_draw
    all.each do |box|
      box_number = "%03d" % box.number
      box_combos =  [ "#{box_number[0]}#{box_number[1]}#{box_number[2]}".to_i,
                      "#{box_number[0]}#{box_number[2]}#{box_number[1]}".to_i,
                      "#{box_number[1]}#{box_number[0]}#{box_number[2]}".to_i,
                      "#{box_number[1]}#{box_number[2]}#{box_number[0]}".to_i,
                      "#{box_number[2]}#{box_number[0]}#{box_number[1]}".to_i,
                      "#{box_number[2]}#{box_number[1]}#{box_number[0]}".to_i]
      last_drawing = PickThree.where(["numbers in (?)", box_combos]).order('drawing_date DESC').first
      box.update(last_draw: last_drawing.drawing_date)
    end
  end
end
