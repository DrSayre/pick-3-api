class Wheel
  def self.generate(draw_time)
    overall = [ prune(PickThree.group('first_ball').count),
                prune(PickThree.group('second_ball').count),
                prune(PickThree.group('third_ball').count)]
    draw = DrawingTime.find_by(name: draw_time)
    drawing = [ prune(draw.pick_threes.group('first_ball').count),
                prune(draw.pick_threes.group('second_ball').count),
                prune(draw.pick_threes.group('third_ball').count)]
    overall_total = merge_breakdowns(PickThree.group('first_ball').count, PickThree.group('second_ball').count, PickThree.group('third_ball').count)
    drawing_total = merge_breakdowns(draw.pick_threes.group('first_ball').count, draw.pick_threes.group('second_ball').count, draw.pick_threes.group('third_ball').count)
    overall_numbers = prune(overall_total)
    drawing_numbers = prune(drawing_total)
    return [(overall[0] + drawing[0] + overall_numbers + drawing_numbers).uniq.sort, (overall[1] + drawing[1] + overall_numbers + drawing_numbers).uniq.sort, (overall[2] + drawing[2] + overall_numbers + drawing_numbers).uniq.sort]
  end

  def self.prune(breakdown)
    breakdown.select{ |k,v| v < breakdown.mean - breakdown.standard_deviation }.map{ |key, value| key }
  end

  def self.merge_breakdowns(breakdown1, breakdown2, breakdown3)
    return {0 => breakdown1[0] + breakdown2[0] + breakdown3[0],
            1 => breakdown1[1] + breakdown2[1] + breakdown3[1],
            2 => breakdown1[2] + breakdown2[2] + breakdown3[2],
            3 => breakdown1[3] + breakdown2[3] + breakdown3[3],
            4 => breakdown1[4] + breakdown2[4] + breakdown3[4],
            5 => breakdown1[5] + breakdown2[5] + breakdown3[5],
            6 => breakdown1[6] + breakdown2[6] + breakdown3[6],
            7 => breakdown1[7] + breakdown2[7] + breakdown3[7],
            8 => breakdown1[8] + breakdown2[8] + breakdown3[8],
            9 => breakdown1[9] + breakdown2[9] + breakdown3[9]
          }
  end
end
