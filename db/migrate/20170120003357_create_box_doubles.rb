class CreateBoxDoubles < ActiveRecord::Migration[5.0]
  def change
    create_table :box_doubles do |t|
      t.integer :number
      t.date :last_draw

      t.timestamps
    end
    BoxDouble.create([{number: 1}, {number: 2}, {number: 3}, {number: 4}, {number: 5}, {number: 6}, {number: 7}, {number: 8}, {number: 9}, {number: 11}, {number: 22}, {number: 33}, {number: 44}, {number: 55}, {number: 66}, {number: 77}, {number: 88}, {number: 99}, {number: 112}, {number: 113}, {number: 114}, {number: 115}, {number: 116}, {number: 117}, {number: 118}, {number: 119}, {number: 122}, {number: 133}, {number: 144}, {number: 155}, {number: 166}, {number: 177}, {number: 188}, {number: 199}, {number: 223}, {number: 224}, {number: 225}, {number: 226}, {number: 227}, {number: 228}, {number: 229}, {number: 233}, {number: 244}, {number: 255}, {number: 266}, {number: 277}, {number: 288}, {number: 299}, {number: 334}, {number: 335}, {number: 336}, {number: 337}, {number: 338}, {number: 339}, {number: 344}, {number: 355}, {number: 366}, {number: 377}, {number: 388}, {number: 399}, {number: 445}, {number: 446}, {number: 447}, {number: 448}, {number: 449}, {number: 455}, {number: 466}, {number: 477}, {number: 488}, {number: 499}, {number: 556}, {number: 557}, {number: 558}, {number: 559}, {number: 566}, {number: 577}, {number: 588}, {number: 599}, {number: 667}, {number: 668}, {number: 669}, {number: 677}, {number: 688}, {number: 699}, {number: 778}, {number: 779}, {number: 788}, {number: 799}, {number: 889}, {number: 899}])
  end
end
