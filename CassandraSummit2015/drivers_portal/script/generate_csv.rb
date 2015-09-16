#!/usr/bin/env ruby

require 'csv'

CSV_FILE = 'trips.csv'

def range (min, max)
    rand * (max-min) + min
end

CSV.open(CSV_FILE, 'wb') do |csv|
  csv << %w(driver_id start_time end_time start_location end_location)

  10_000.times do |i|
    driver_id = i % 100
    start_time = Time.at(rand(Time.now.to_i))
    end_time = start_time + rand(10000)
    start_location = "#{range(-90.0, 90.0)}, #{range(-180.0, 180.0)}"
    end_location = "#{range(-90.0, 90.0)}, #{range(-180.0, 180.0)}"
    csv << [driver_id, start_time, end_time, start_location, end_location]
  end
end
