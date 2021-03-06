
db = require "lapis.db"

import p from require "moon"

-- usage broken by top level directory
p db.query [[
  select count(*), pg_size_pretty(sum(sc_bytes)) bandwidth,
    substring(cs_object from '^\w+') path from requests group by path;
]]

-- most consuming files
p db.query [[
  select count(*), pg_size_pretty(sum(sc_bytes)) bandwidth,
    cs_object from requests group by cs_object order by sum(sc_bytes) desc limit 20;
]]


-- most consuming game ids
p db.query [[
  select count(*), pg_size_pretty(sum(sc_bytes)) bandwidth,
    substring(cs_object from '\d+') game_id
  from requests group by game_id order by sum(sc_bytes) desc limit 20;
]]

-- requests and bandwidth per day
p db.query [[
  select d, count(*), pg_size_pretty(sum(sc_bytes)) from
    (select
      date_trunc('day', to_timestamp(time_micros / 1000000)) as d,
      sc_bytes
      from requests) as dates
    group by d
    order by d desc;
]]
