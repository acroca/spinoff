class Spinoff.Models.AdContract extends Backbone.Model
  urlRoot: "/api/v1/ad_contracts"
  paramRoot: 'ad_contract'

  defaults:
    company_id: null
    price: null
    advertiser: null

class Spinoff.Collections.AdContractsCollection extends Backbone.Collection
  model: Spinoff.Models.AdContract
  url: '/api/v1/ad_contracts'

  comparator: (adContract) ->
    adContract.get("price")

window.adContractsCollection = new Spinoff.Collections.AdContractsCollection()
