class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.string      :gender
      t.datetime    :start_year_of_golf
      t.integer     :best_overall_score
      t.string      :favorite_course_ever
      t.string      :favorite_golfer_in_finland
      t.string      :favorite_golfer_abroad
      t.string      :desc
      t.string      :play_time_of_day
      t.boolean     :visitors_to_home_course
      t.boolean     :has_car_to_share
      t.datetime    :birthday
      
      t.references :user
    end
  end

  def self.down
    drop_table :specs
  end
end
