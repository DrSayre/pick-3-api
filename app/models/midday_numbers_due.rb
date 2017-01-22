class MiddayNumbersDue < DrawingMath
  self.table_name = 'z_midday_numbers_due'

  def self.spike
    numbers_due = all
    candidates = []
    box_singles = MiddayBoxSinglesDue.select(:number)
    box_doubles = MiddayBoxDoublesDue.select(:number)
    boxes = (box_singles + box_doubles).map{|box| box.number}
    print boxes.inspect
    numbers_due.each do |due|
      good = boxes.include? due.box_value
      candidates << due.numbers if good
    end
    prune_numbers(candidates, 'midday').sort
  end
end