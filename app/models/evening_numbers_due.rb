class EveningNumbersDue < DrawingMath
  self.table_name = 'z_evening_numbers_due'

  def self.spike
    numbers_due = all
    candidates = []
    box_singles = EveningBoxSinglesDue.select(:number)
    box_doubles = EveningBoxDoublesDue.select(:number)
    numbers_due.each do |due|
      good = box_singles.include? due.box_value
      good = box_doubles.include? due.box_value
      candidates << due.numbers if good
    end
    candidates
  end
end
