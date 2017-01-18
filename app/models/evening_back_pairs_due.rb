class EveningBackPairsDue < ApplicationRecord
  self.table_name = 'evening_back_pairs_due'
  def self.wheel
    numbers = []
    all.each do |number|
      numbers << number.back_pair.to_s if foo(number.back_pair)
    end
    numbers
  end

  def self.foo(number)
    padded_numbers = '%02d' % number 
    draws = PickThree.where(['drawing_date >= ?', BackPairCount.find_by(back_pair: number).last_draw])
    first_ball = draws.group(:second_ball).count
    first_candidates = candidate_balls(first_ball)
    return false if first_candidates.exclude? padded_numbers[0].to_i

    second_ball = draws.group(:third_ball).count
    second_candidates = candidate_balls(second_ball)
    return false if second_candidates.exclude? padded_numbers[1].to_i
    true
  end

  def self.candidate_balls(hash)
    array = hash.map{ |key, value| value}
    mean = array.mean
    st_dev = array.standard_deviation
    qual = mean - st_dev
    hash.map{ |key, value| key.to_i if value < qual }.compact
  end
end