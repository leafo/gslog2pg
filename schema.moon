
db = require "lapis.db"

-- {
--     [time_taken_micros] = "398000"
--     [cs_bucket] = "itchio"
--     [cs_host] = "commondatastorage.googleapis.com"
--     [cs_user_agent] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36,gzip(gfe)"
--     [cs_referer] = "http://jwillc.itch.io/flappy-math"
--     [cs_uri] = "/itchio/upload/2762/FlappyMath_v1.2.exe?GoogleAccessId=507810471102@developer.gserviceaccount.com&Expires=1399780860&Signature=JVhpxQJqUZvIJG5H8VjVAiHYNaaCiy660vc1doPoXK%2FRf9kkJwylE6a8271mQdf16jTCTBdQ8liFm3F8s7c2hBLgkil582iDJCNutTRjVjeGyTo9yTa48tPDr7kAZWuGVZXgFC0Epezdp9Hu4DP28FP42D74cM0t4Sa%2BrvlcQnk="
--     [sc_bytes] = "4014521"
--     [c_ip] = "70.117.166.117"
--     [sc_status] = "200"
--     [cs_bytes] = "0"
--     [time_micros] = "1399780850839000"
--     [cs_object] = "upload/2762/FlappyMath_v1.2.exe"
--     [s_request_id] = "AEnB2UpEVWja8XWLvT9Yvn2Gg3hH_Pb02ZQ6Iqr0nwfZofxbw9v6gbjbAV_WgkC4K-vSvfsMH-F4QYTOBMBNrndHw66mbt2VhQ"
--     [c_ip_region] = ""
--     [cs_method] = "GET"
--     [cs_operation] = "GET_Object"
--     [c_ip_type] = "1"
-- }


import
  types
  create_table
  create_index
  from require "lapis.db.schema"


-- log files that have already been imported
create_table "log_files", {
  {"filename", types.varchar}

  "PRIMARY KEY(filename)"
}

-- a row from log file
create_table "requests", {
  {"id", types.serial}
  {"s_request_id", types.varchar}

  {"cs_bucket", types.varchar}
  {"cs_host", types.varchar}
  {"cs_user_agent", types.varchar}
  {"cs_referer", types.varchar}
  {"cs_uri", types.text}
   
  {"time_micros", types.numeric} -- The time that the request was completed, in microseconds since the Unix epoch

  {"sc_bytes", types.integer} -- The number of bytes sent in the response
  {"cs_bytes", types.integer} -- The number of bytes sent in the request
  {"c_ip", types.varchar}
  {"sc_status", types.integer}
  {"cs_object", types.varchar}
  {"cs_method", types.varchar}

  "PRIMARY KEY(id)"
}

create_index "requests", "s_request_id", unique: true


