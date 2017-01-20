class EveningNumbersDue < DrawingMath
  self.table_name = 'z_evening_numbers_due'

  def self.spike
    numbers_due = all
    candidates = []
    box_singles = EveningBoxSinglesDue.select(:number)
    box_doubles = EveningBoxDoublesDue.select(:number)
    boxes = (box_singles + box_doubles).map{|box| box.number}
    numbers_due.each do |due|
      good = boxes.include? due.box_value
      candidates << due.numbers if good
    end
    candidates
  end
end
