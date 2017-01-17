class TwitterController < ApplicationController
  def midday
    numbers = PickThree.wheel('midday')
    tweet = "Today's drawing: #{numbers.join(', ')} #KYPick3"
    print "\n**********\n#{tweet}\n**********\n"
    $twitter.update(tweet)
    render status: 204
  end

  def evening
    numbers = PickThree.wheel('evening')
    tweet = "Tonight's drawing: #{numbers.join(', ')} #KYPick3"
    print "\n**********\n#{tweet}\n**********\n"
    $twitter.update(tweet)
    render status: 204
  end

  def update
    midday = DrawingTime.where(name: 'Midday').first_or_create
    evening = DrawingTime.where(name: 'Evening').first_or_create
    save_numbers(midday, 'Midday-Pick-3')
    save_numbers(evening, 'Pick-3')
  end

  def save_numbers(drawing_time, drawing)
    months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    last_year = PickThree.maximum(:drawing_date).year
    (last_year..Time.now.year).each do |year|
      months.each do |month|
        url = "https://www.alllotto.com/Kentucky-#{drawing}-#{month}-#{year}-Lottery-Results.php"
        page = HTTParty.get(url)
        parse_page = Nokogiri::HTML(page)
        table = parse_page.css('table')[4]
        table_rows = table.css('tr')
        table_rows.each do |row|
          if row.css('td').first.text.include? 'Pick 3'
            date_parts = row.css('td')[1].text.split('-')
            date = Date.new(date_parts[2].to_i, date_parts[0].to_i, date_parts[1].to_i)
            numbers = row.css('td')[2].text.split(',')
            numbers.map!{ |number| number.delete(' ')}
            begin
              drawing_time.pick_threes.create(first_ball: numbers[0], second_ball: numbers[1], third_ball: numbers[2], drawing_date: date)
            rescue
              print "\n------\n#{date} - #{numbers.inspect} Already recorded\n------\n"
            end
            print "\n------\n#{date} - #{numbers.inspect}\n------\n" 
          end
        end
      end
    end
  end

  def evening_wheel
    
  end
end
