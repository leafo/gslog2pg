
db = require "lapis.db"

import
  types
  create_table
  create_index
  from require "lapis.db.schema"

-- db.query "drop table log_files"

-- log files that have already been imported
create_table "log_files", {
  {"filename", types.varchar}

  "PRIMARY KEY(filename)"
}

-- db.query "drop table requests"

-- a row from log file
create_table "requests", {
  {"time_micros", "bigint not null"} -- The time that the request was completed, in microseconds since the Unix epoch

  {"c_ip", types.text}
  {"c_ip_type", types.integer}
  {"c_ip_region", types.text}

  {"cs_method", types.text}
  {"cs_uri", types.text}
  {"sc_status", types.integer}
  {"cs_bytes", types.integer} -- The number of bytes sent in the request
  {"sc_bytes", types.integer} -- The number of bytes sent in the response

  {"time_taken_micros", "bigint not null"}

  {"cs_host", types.text}
  {"cs_referer", types.text}
  {"cs_user_agent", types.text}
  {"s_request_id", types.text}

  {"cs_operation", types.text}
  {"cs_bucket", types.text}
  {"cs_object", types.text}

  "PRIMARY KEY(s_request_id)"
}

create_index "requests", "time_micros"

