Promise = require 'bluebird'
{lookup} = require 'country-data'

class GetCurrency

  constructor: (@logger) ->

  run: (country) ->
    new Promise (resolve, reject) ->
      data = lookup.countries({alpha2: country})[0]
      resolve data.currencies[0]

module.exports = GetCurrency