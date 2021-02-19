-- up
create index result_timestamp_index on results(timestamp);

-- down
DROP index if exists result_timestamp_index;
