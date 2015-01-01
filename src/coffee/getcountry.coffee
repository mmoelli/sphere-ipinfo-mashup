ipinfo = require 'ipinfo'
Promise = require 'bluebird'

class GetCountry

  constructor: (@logger) ->

  run: (ipAddress = "") ->
    new Promise (resolve, reject) ->
      if ipAddress is ''
        ipinfo (err, info) ->
          if err
            reject "Problem with reaching ipinfo.io API: #{err}"
          else
            console.log "IP address used: " + info.ip
            resolve info.country
      else
        ipinfo ipAddress, (err, info) ->
          if err
            reject "Problem with reaching ipinfo.io API: #{err}"
          else
            console.log "IP address used: " + info.ip
            resolve info.country

module.exports = GetCountry