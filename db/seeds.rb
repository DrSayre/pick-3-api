# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def save_numbers(drawing_time, drawing)
  months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  # last_date = PickThree.maximum(:drawing_date).year
  (1998..Time.now.year).each do |year|
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

midday = DrawingTime.where(name: 'Midday').first_or_create
evening = DrawingTime.where(name: 'Evening').first_or_create
save_numbers(midday, 'Midday-Pick-3')
save_numbers(evening, 'Pick-3')
