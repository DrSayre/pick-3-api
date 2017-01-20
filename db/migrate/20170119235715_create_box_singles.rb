class CreateBoxSingles < ActiveRecord::Migration[5.0]
  def change
    create_table :box_singles do |t|
      t.integer :number
      t.date :last_draw

      t.timestamps
    end
    BoxSingle.create([{number: 12}, {number: 13}, {number: 14}, {number: 15}, {number: 16}, {number: 17}, {number: 18}, {number: 19}, {number: 23}, {number: 24}, {number: 25}, {number: 26}, {number: 27}, {number: 28}, {number: 29}, {number: 34}, {number: 35}, {number: 36}, {number: 37}, {number: 38}, {number: 39}, {number: 45}, {number: 46}, {number: 47}, {number: 48}, {number: 49}, {number: 56}, {number: 57}, {number: 58}, {number: 59}, {number: 67}, {number: 68}, {number: 69}, {number: 78}, {number: 79}, {number: 89}, {number: 123}, {number: 124}, {number: 125}, {number: 126}, {number: 127}, {number: 128}, {number: 129}, {number: 134}, {number: 135}, {number: 136}, {number: 137}, {number: 138}, {number: 139}, {number: 145}, {number: 146}, {number: 147}, {number: 148}, {number: 149}, {number: 156}, {number: 157}, {number: 158}, {number: 159}, {number: 167}, {number: 168}, {number: 169}, {number: 178}, {number: 179}, {number: 189}, {number: 234}, {number: 235}, {number: 236}, {number: 237}, {number: 238}, {number: 239}, {number: 245}, {number: 246}, {number: 247}, {number: 248}, {number: 249}, {number: 256}, {number: 257}, {number: 258}, {number: 259}, {number: 267}, {number: 268}, {number: 269}, {number: 278}, {number: 279}, {number: 289}, {number: 345}, {number: 346}, {number: 347}, {number: 348}, {number: 349}, {number: 356}, {number: 357}, {number: 358}, {number: 359}, {number: 367}, {number: 368}, {number: 369}, {number: 378}, {number: 379}, {number: 389},  {number: 456},  {number: 456},  {number: 457}, {number: 458}, {number: 459}, {number: 467}, {number: 468}, {number: 469}, {number: 478}, {number: 479}, {number: 489}, {number: 567}, {number: 568}, {number: 569}, {number: 578}, {number: 579}, {number: 589}, {number: 678}, {number: 679}, {number: 689}, {number: 789}])
  end
end
