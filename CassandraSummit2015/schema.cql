CREATE KEYSPACE csummit WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 2 };

USE csummit;

CREATE TABLE comments (
  conversation INT,
  time TIMESTAMP,
  user VARCHAR,
  contents TEXT,
  PRIMARY KEY (conversation, time)
);
