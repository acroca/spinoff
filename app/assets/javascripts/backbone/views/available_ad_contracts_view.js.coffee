class Spinoff.Views.AvailableAdContractsView extends Backbone.View
  template: JST["backbone/templates/available_ad_contracts"]

  initialize: (opts) ->
    @collection.bind 'reset remove add', @render, @

  render: ->
    $(@el).html(@template())
    listElement = @$('table > tbody')
    listElement.empty()
    for adContract in @collection.models
      adContractView = new Spinoff.Views.AvailableAdContractView(model: adContract)
      listElement.append adContractView.render().el
    @

class Spinoff.Views.AvailableAdContractView extends Backbone.View
  template: JST["backbone/templates/available_ad_contract"]
  tagName: 'tr'

  events:
    "click .sign": "sign"

  initialize: ->
    @model.bind 'change', @render, @
    company.bind 'change', @render, @

  render: ->
    content = $(@template(adContract: @model))
    $(@el).html(content)
    @

  sign: (e) ->
    e.preventDefault()
    @model.set(company_id: company.get("id"))
    @model.save()
    company.adContracts.add(@model)
    $(@el).remove()
    @
