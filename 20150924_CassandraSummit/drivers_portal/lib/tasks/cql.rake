# ******************************************************************************
# NOTE: You will need to replace keyspace and migrations_path in the rake tasks
# below with whatever makes sense for your application. You will also need a
# task named environment that loads whatever is need to make cassanity available.
# ******************************************************************************
namespace :cql do

  def display_migrations(migrations)
    max_size = migrations.map(&:name).map(&:size).max + 1
    migrations.each do |migration|
      display_migration migration, size: max_size
    end
  end

  def display_migration(migration, options = {})
    size = options[:size] || migration.name.size
    puts "- #{migration.name.ljust(size)} #{migration.version}"
  end

  def migrator
    @migrator ||= begin
      require 'cassanity/migrator'

      migrations_path = File.expand_path("../../../db/migrate", __FILE__)
      Cassanity::Migrator.new(keyspace, migrations_path)
    end
  end

  def keyspace
    @keyspace ||= begin
      config = YAML::load_file('config/cql.yml')[environment]
      Cassanity::Client.new(config[:hosts], config[:port])[config[:keyspace].to_sym]
    end
  end

  def environment
    ENV['MYDRIVE_ENV'] || ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  desc "Run any pending migrations."
  task migrate: :create do
    if ENV["VERSION"]
      version = ENV["VERSION"].to_i
      direction = ENV.fetch('DIRECTION', :up).to_sym
      migrator.migrate_to(version, direction)
    else
      migrator.migrate
    end
  end

  desc "List pending migrations."
  task :pending do
    pending = migrator.pending_migrations

    display_migrations pending
  end

  desc "List all migrations."
  task :migrations do
    display_migrations migrator.migrations
  end

  desc "Create the keyspace"
  task :create do
    unless keyspace.exists?
      puts "Creating keyspace #{keyspace.name}"
      keyspace.create
    end
  end

  desc "Drop the keyspace"
  task :drop do
    if keyspace.exists?
      puts "Dropping keyspace #{keyspace.name}"
      keyspace.drop
    end
  end
end
