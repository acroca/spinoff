class Spinoff.Views.MyAdContractsView extends Backbone.View
  template: JST["backbone/templates/my_ad_contracts"]

  render: ->
    $(@el).html(@template())
    listElement = @$('table > tbody')
    listElement.empty()
    for adContract in @collection.models
      adContractView = new Spinoff.Views.MyAdContractView(model: adContract)
      listElement.append adContractView.render().el
    @

class Spinoff.Views.MyAdContractView extends Backbone.View
  template: JST["backbone/templates/my_ad_contract"]
  tagName: 'tr'

  render: ->
    content = $(@template(adContract: @model))
    $(@el).html(content)
    @
