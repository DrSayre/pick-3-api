class PickThree < ApplicationRecord
  belongs_to :drawing_time
  before_save :set_pairs
  after_save :box_update

  def box_update
    BoxSingle.update_last_draw
    BoxDouble.update_last_draw
  end

  def set_pairs
    self.front_pair = first_ball * 10 + second_ball
    self.back_pair = second_ball * 10 + third_ball
    self.split_pair = first_ball * 10 + third_ball
    self.numbers = first_ball * 100 + second_ball * 10 + third_ball
  end

  def self.wheel(drawing)
    numbers = possible_numbers(drawing)
    first_ball = first_ball_due(drawing)
    second_ball = second_ball_due(drawing)
    third_ball = third_ball_due(drawing)
    front_pairs = front_pairs_due(drawing)
    split_pairs = split_pairs_due(drawing)
    back_pairs = back_pairs_due(drawing)
    numbers.delete_if{ |number| first_ball.exclude? number.chars[0].to_i }
    numbers.delete_if{ |number| second_ball.exclude? number.chars[1].to_i }
    numbers.delete_if{ |number| third_ball.exclude? number.chars[2].to_i }
    numbers.delete_if{ |number| front_pairs.exclude? (number.chars[0] + number.chars[1]).to_i }
    numbers.delete_if{ |number| split_pairs.exclude? (number.chars[0] + number.chars[2]).to_i }
    numbers.delete_if{ |number| back_pairs.exclude? (number.chars[1] + number.chars[2]).to_i }
    recent_draws = PickThree.where(numbers: numbers).where('drawing_date > :year_ago', {year_ago: 1.year.ago}).map{|recent| recent.numbers}
    numbers.delete_if{ |number| recent_draws.include? number.to_i}
    more_numbers = MiddayNumbersDue.wheel if drawing == 'midday'
    more_numbers = EveningNumbersDue.wheel if drawing == 'evening'
    (numbers + numbers_due + more_numbers).uniq.sort
  end

  def self.possible_numbers(drawing)
    all = FullNumberCount.all.map{ |numbers| numbers.quanity }
    all = all.mean - all.standard_deviation
    all = FullNumberCount.where("quanity < #{all}").map{ |numbers| numbers.numbers }
    if drawing == 'midday'
      evening = MiddayFullNumberCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddayFullNumberCount.where("quanity < #{evening}").map{ |numbers| numbers.numbers }
    else
      evening = EveningFullNumberCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningFullNumberCount.where("quanity < #{evening}").map{ |numbers| numbers.numbers }
    end
    (all + evening).uniq.map{ |number| "%03d" % number }
  end

  def self.first_ball_due(drawing)
    all = FirstBallCount.all.map{ |first| first.quanity }
    all = all.mean - all.standard_deviation
    all = FirstBallCount.where("quanity < #{all}").map{ |numbers| numbers.first_ball }
    if drawing == 'midday'
      evening = MiddayFirstBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddayFirstBallCount.where("quanity < #{evening}").map{ |numbers| numbers.first_ball }
    else
      evening = EveningFirstBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningFirstBallCount.where("quanity < #{evening}").map{ |numbers| numbers.first_ball }
    end
    (all + evening).uniq
  end

  def self.second_ball_due(drawing)
    all = SecondBallCount.all.map{ |second| second.quanity }
    all = all.mean - all.standard_deviation
    all = SecondBallCount.where("quanity < #{all}").map{ |numbers| numbers.second_ball }
    if drawing == 'midday'
      evening = MiddaySecondBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddaySecondBallCount.where("quanity < #{evening}").map{ |numbers| numbers.second_ball }
    else
      evening = EveningSecondBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningSecondBallCount.where("quanity < #{evening}").map{ |numbers| numbers.second_ball }
    end
    (all + evening).uniq
  end

  def self.third_ball_due(drawing)
    all = ThirdBallCount.all.map{ |third| third.quanity }
    all = all.mean - all.standard_deviation
    all = ThirdBallCount.where("quanity < #{all}").map{ |numbers| numbers.third_ball }
    if drawing == 'midday'
      evening = MiddayThirdBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddayThirdBallCount.where("quanity < #{evening}").map{ |numbers| numbers.third_ball }
    else
      evening = EveningThirdBallCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningThirdBallCount.where("quanity < #{evening}").map{ |numbers| numbers.third_ball }
    end
    (all + evening).uniq
  end

  def self.front_pairs_due(drawing)
    all = FrontPairCount.all.map{ |third| third.quanity }
    all = all.mean - all.standard_deviation
    all = FrontPairCount.where("quanity < #{all}").map{ |numbers| numbers.front_pair }
    if drawing == 'midday'
      evening = MiddayFrontPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddayFrontPairCount.where("quanity < #{evening}").map{ |numbers| numbers.front_pair }
    else
      evening = EveningFrontPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningFrontPairCount.where("quanity < #{evening}").map{ |numbers| numbers.front_pair }
    end
    (all + evening).uniq
  end

  def self.split_pairs_due(drawing)
    all = SplitPairCount.all.map{ |third| third.quanity }
    all = all.mean - all.standard_deviation
    all = SplitPairCount.where("quanity < #{all}").map{ |numbers| numbers.split_pair }
    if drawing == 'midday'
      evening = MiddaySplitPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddaySplitPairCount.where("quanity < #{evening}").map{ |numbers| numbers.split_pair }
    else
      evening = EveningSplitPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningSplitPairCount.where("quanity < #{evening}").map{ |numbers| numbers.split_pair }
    end
    (all + evening).uniq
  end

  def self.back_pairs_due(drawing)
    all = BackPairCount.all.map{ |third| third.quanity }
    all = all.mean - all.standard_deviation
    all = BackPairCount.where("quanity < #{all}").map{ |numbers| numbers.back_pair }
    if drawing == 'midday'
      evening = MiddayBackPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = MiddayBackPairCount.where("quanity < #{evening}").map{ |numbers| numbers.back_pair }
    else
      evening = EveningBackPairCount.all.map{ |numbers| numbers.quanity }
      evening = evening.mean - evening.standard_deviation
      evening = EveningBackPairCount.where("quanity < #{evening}").map{ |numbers| numbers.back_pair }
    end
    (all + evening).uniq
  end

  def self.numbers_due
    numbers = FullNumberCount.where('last_draw < :five_hundred_days_ago', {five_hundred_days_ago: 500.days.ago}).map{ |number| "%03d" % number.numbers}
    first_balls = FirstBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |first| first.first_ball }
    second_balls = SecondBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |second| second.second_ball }
    third_balls = ThirdBallCount.where('last_draw < :five_days_ago', {five_days_ago: 5.days.ago}).map{ |third| third.third_ball }
    front_pairs = FrontPairCount.where('last_draw < :fifty_days_ago', {fifty_days_ago: 50.days.ago}).map{ |front| front.front_pair }
    split_pairs = SplitPairCount.where('last_draw < :fifty_days_ago', {fifty_days_ago: 50.days.ago}).map{ |split| split.split_pair }
    back_pairs = BackPairCount.where('last_draw < :fifty_days_ago', {fifty_days_ago: 50.days.ago}).map{ |back| back.back_pair }
    numbers.delete_if{ |number| first_balls.exclude? number.chars[0].to_i }
    numbers.delete_if{ |number| second_balls.exclude? number.chars[1].to_i }
    numbers.delete_if{ |number| third_balls.exclude? number.chars[2].to_i }
    numbers.delete_if{ |number| front_pairs.exclude? (number.chars[0] + number.chars[1]).to_i }
    numbers.delete_if{ |number| split_pairs.exclude? (number.chars[0] + number.chars[2]).to_i }
    numbers.delete_if{ |number| back_pairs.exclude? (number.chars[1] + number.chars[2]).to_i }
    numbers
  end
end
