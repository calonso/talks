
require 'yaml'

module ConfigUtils
  def environment
    ENV['MYDRIVE_ENV'] || ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def cql_config
    @config ||= YAML::load_file('config/cql.yml')[environment]
  end
end
