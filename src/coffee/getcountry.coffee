ipinfo = require 'ipinfo'

class GetCountry

  constructor: (@logger) ->

  run: (ipAddress = "") ->
    if ipAddress == ""
      ipinfo ipAddress, (err, info) ->
        if err
          logger.error err, 'Oops, something went wrong when trying to reach ipinfo.io API.'
          @exitCode = 1

        @country = info.country
    else
      ipinfo (err, info) ->
        if err
          logger.error err, 'Oops, something went wrong when trying to reach ipinfo.io API.'
          @exitCode = 1

        @country = info.country