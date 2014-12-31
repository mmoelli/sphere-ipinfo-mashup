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
            resolve @country = info.country
      else
        ipinfo ipAddress, (err, info) ->
          if err
            reject "Problem with reaching ipinfo.io API: #{err}"
          else
            resolve @country = info.country

module.exports = GetCountry