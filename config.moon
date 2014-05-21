config = require "lapis.config"

config "development", ->
  bucket "itchio_logging"

  postgres {
    backend: "pgmoon"
    database: "gslog"
  }

