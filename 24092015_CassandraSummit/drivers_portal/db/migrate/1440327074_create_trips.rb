class CreateTrips < Cassanity::Migration
  def up
    create_column_family :trips, {
      primary_key: [:driver_id, :end_time],
      columns: {
        driver_id: :int,
        start_time: :timestamp,
        end_time: :timestamp,
        start_location: :varchar,
        end_location: :varchar
      },
    }
  end

  def down
    drop_column_family :trips
  end
end
