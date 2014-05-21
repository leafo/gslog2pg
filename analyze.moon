
-- the keys that we keep
KEYS = {
  "s_request_id", "cs_bucket", "cs_host", "cs_user_agent", "cs_referer",
  "cs_uri", "time_micros", "sc_bytes", "cs_bytes", "c_ip", "sc_status",
  "cs_object", "cs_method"
}


db = require "lapis.db"

lfs = require "lfs"
csv = require "csv"

import p from require "moon"

file_pattern = "usage"
dir = ... or "itchio_logging/"

handle_file = (file) ->
  if unpack db.query "select 1 from log_files where filename = ?", file
    print "Skipping file #{file}"
    return

  f = csv.open file

  local index
  for fields in f\lines!
    unless index
      index = {name, i for i, name in pairs fields}
      continue

    insert = {}
    for key in *KEYS
      insert[key] = fields[index[key]]

    db.insert "requests", insert
  
  db.insert "log_files", filename: file
  true

for file in lfs.dir dir
  continue unless file\match file_pattern
  handle_file "#{dir}#{file}"
  os.exit!
