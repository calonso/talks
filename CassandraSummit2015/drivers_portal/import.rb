#!/usr/bin/env bundle exec ruby

$:.unshift File.join(File.dirname(__FILE__), 'lib')

Bundler.setup
Bundler.require

require 'csv'
require 'utils/config_utils'

include ConfigUtils

CSV_FILE = 'trips.csv'

statsd = Statsd.new 'localhost', 8125

t0 = Time.now

client = Cassanity::Client.new(cql_config[:hosts], cql_config[:port])

trips_cf = client[cql_config[:keyspace]].column_family :trips

prepared_insert = trips_cf.prepare_insert fields: [
  :driver_id, :start_time, :end_time, :start_location, :end_location
]

futures = []

CSV.foreach(CSV_FILE, headers: true, header_converters: :symbol, converters: :all) do |trip|
  hsh = trip.to_hash.merge(start_time: Time.parse(trip[:start_time]), end_time: Time.parse(trip[:end_time]))
  futures << prepared_insert.execute_async(hsh)
end

Cassanity::Future.wait_all futures

delta = Time.now - t0
statsd.timing 'import_time', delta


