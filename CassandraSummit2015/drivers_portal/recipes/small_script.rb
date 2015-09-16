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

results = RubyProf.profile do
  cluster = Cassandra.cluster hosts: cql_config[:hosts]

  session = cluster.connect cql_config[:keyspace]

  session.execute "
    INSERT INTO trips (driver_id, start_time, end_time, start_location, end_location) VALUES
    (1, '#{Time.now}', '#{Time.now + 10}', '1, 1', '2, 2')"
end

printer = RubyProf::GraphPrinter.new results
printer.print(STDOUT, min_percent: 2)

delta = Time.now - t0
statsd.timing 'test_time', delta
