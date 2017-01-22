class DrawingMath < ApplicationRecord
  def self.wheel
    numbers = []
    all.each do |number|
      numbers << number.numbers.to_s if foo(number.numbers)
    end
    numbers
  end

  def self.foo(number)
    padded_numbers = '%03d' % number 
    draws = PickThree.where(['drawing_date >= ?', NumbersDue.find_by(numbers: number).last_draw])
    first_ball = draws.group(:first_ball).count
    first_candidates = candidate_balls(first_ball)
    return false if first_candidates.exclude? padded_numbers[0].to_i

    second_ball = draws.group(:second_ball).count
    second_candidates = candidate_balls(second_ball)
    return false if second_candidates.exclude? padded_numbers[1].to_i
    
    third_ball = draws.group(:third_ball).count
    third_candidates = candidate_balls(third_ball)
    return false if third_candidates.exclude? padded_numbers[2].to_i
    
    true
  end

  def self.box_foo(number)
    padded_numbers = '%03d' % number
    numbers_count = [padded_numbers[0], padded_numbers[1], padded_numbers[2]].uniq.count
    if numbers_count == 3
      draws = PickThree.where(['drawing_date >= ?', BoxSingle.find_by(number: number).last_draw])
    elsif numbers_count == 2
      draws = PickThree.where(['drawing_date >= ?', BoxDouble.find_by(number: number).last_draw])
    else
      return false
    end
    first_ball = draws.group(:first_ball).count
    first_candidates = candidate_balls(first_ball)
    return false if first_candidates.exclude? padded_numbers[0].to_i

    second_ball = draws.group(:second_ball).count
    second_candidates = candidate_balls(second_ball)
    return false if second_candidates.exclude? padded_numbers[1].to_i
    
    third_ball = draws.group(:third_ball).count
    third_candidates = candidate_balls(third_ball)
    return false if third_candidates.exclude? padded_numbers[2].to_i
    
    true
  end

  def self.candidate_balls(hash)
    array = hash.map{ |key, value| value}
    mean = array.mean
    st_dev = array.standard_deviation
    qual = mean - st_dev
    hash.map{ |key, value| key.to_i if value < qual }.compact
  end

  def self.straight_box
    box_combos = BoxSingle.where('last_draw < :eighty_four_days_ago', {eighty_four_days_ago: 84.days.ago}) + BoxDouble.where('last_draw < :hundred_sixy_eight_days_ago', {hundred_sixy_eight_days_ago: 168.days.ago})
    box_combos = box_combos.map{ |box| "%03d" % box.number }
    total_combos = []
    box_combos.each do |box|
      total_combos << ["#{box[0]}#{box[1]}#{box[2]}".to_i,
                      "#{box[0]}#{box[2]}#{box[1]}".to_i,
                      "#{box[1]}#{box[0]}#{box[2]}".to_i,
                      "#{box[1]}#{box[2]}#{box[0]}".to_i,
                      "#{box[2]}#{box[0]}#{box[1]}".to_i,
                      "#{box[2]}#{box[1]}#{box[0]}".to_i]
    end
    total_combos.flatten!
    combos = all
    winners = combos.select{|number| total_combos.include? number.numbers}
    winners = winners.select{|winner| foo(winner.numbers)}
    return winners
  end

  def box_value
    padded_numbers = "%03d" % numbers
    array_numbers = [padded_numbers[0], padded_numbers[1], padded_numbers[2]].sort
    "#{array_numbers[0]}#{array_numbers[1]}#{array_numbers[2]}".to_i
  end

  def self.prune_numbers(combos)
    combos.map!{ |combo| "%03d" % combo }
    first_balls = FirstBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |first| first.first_ball }
    second_balls = SecondBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |second| second.second_ball }
    third_balls = ThirdBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |third| third.third_ball }
    combos.delete_if{ |number| first_balls.exclude? number.chars[0].to_i }
    combos.delete_if{ |number| second_balls.exclude? number.chars[1].to_i }
    combos.delete_if{ |number| third_balls.exclude? number.chars[2].to_i }
    combos 
  end
end