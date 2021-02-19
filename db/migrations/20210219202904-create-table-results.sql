-- up
create table results (
  id text primary key,
  timestamp integer not null,
  url text not null,
  download_bandwidth_bytes integer not null,
  upload_bandwidth_bytes integer not null,
  latency_ms NUMBER not null,
  jitter NUMBER not null,
  server_id text not null
);


-- down
drop table results
