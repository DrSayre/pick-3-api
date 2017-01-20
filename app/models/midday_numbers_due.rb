class MiddayNumbersDue < DrawingMath
  self.table_name = 'z_midday_numbers_due'

  def self.spike
    numbers_due = all
    candidates = []
    box_singles = MiddayBoxSinglesDue.select(:number)
    box_doubles = MiddayBoxDoublesDue.select(:number)
    numbers_due.each do |due|
      good = box_singles.include? due.box_value
      good = box_doubles.include? due.box_value
      candidates << due.numbers if good
    end
    candidates
  end
end