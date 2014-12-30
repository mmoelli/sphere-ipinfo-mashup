{SphereClient} = require 'sphere-node-sdk'

class CreateCart

  constructor: (options = {}) ->
    @client = new SphereClient options

  run: (cartCountry) ->
    cart =
      country: cartCountry
      currency: 'EUR'

    @client.carts.save(cart)

    .then (newCart) ->
      console.log "New cart with country: " + newCart.body.country + " and currency " + newCart.body.totalPrice.currencyCode + " was created. (id: " + newCart.body.id + ")"

    .done()

module.exports = CreateCart