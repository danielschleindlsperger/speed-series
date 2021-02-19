CREATE TABLE schema_migrations (version text primary key)
CREATE TABLE results (
  id text primary key,
  timestamp integer not null,
  url text not null,
  download_bandwidth_bytes integer not null,
  upload_bandwidth_bytes integer not null,
  latency_ms NUMBER not null,
  jitter NUMBER not null,
  server_id text not null
)
CREATE INDEX result_timestamp_index on results(timestamp)
CREATE TABLE servers (
  id integer primary key on conflict replace,
  name text not null,
  country text not null,
  location text not null
)