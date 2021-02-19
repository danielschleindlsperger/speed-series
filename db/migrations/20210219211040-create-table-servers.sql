-- up
create table servers (
  id integer primary key on conflict replace,
  name text not null,
  country text not null,
  location text not null
)

-- down
drop table servers
