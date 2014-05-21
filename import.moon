
db = require "lapis.db"
colors = require "ansicolors"
lfs = require "lfs"

import p from require "moon"

config = require("lapis.config").get!

-- TODO: process csv and remove duplicate entires

handle_file = (file) ->
  os.execute "cp '#{dir}/#{file}' /tmp"
  db.query "COPY requests FROM '/tmp/#{file}' DELIMITER ',' CSV HEADER"
  db.insert "log_files", filename: file
  true

update_logs = ->
  seen = { r.filename, true for r in *db.select 'filename from log_files' }

  f = io.popen "gsutil ls 'gs://#{config.bucket}' | grep _usage_ | sort -V -r"
  for url in f\lines!
    file = url\match "([^/]*)$"
    continue if seen[file]

    unless lfs.attributes "/tmp/#{file}"
      print colors "%{bright}%{cyan}Downloading%{reset} #{file}"
      os.execute "gsutil cp #{url} /tmp"

    print colors "%{bright}%{cyan}Importing%{reset} #{file}"

    success, err = pcall ->
      db.query "COPY requests FROM '/tmp/#{file}' DELIMITER ',' CSV HEADER"

    if success
      db.insert "log_files", filename: file
    else
      print err

    print!


update_logs!
