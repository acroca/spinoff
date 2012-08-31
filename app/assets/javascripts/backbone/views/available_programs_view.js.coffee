class Spinoff.Views.AvailableProgramsView extends Backbone.View
  template: JST["backbone/templates/available_programs"]

  initialize: (opts) ->
    @collection.bind 'reset', @render, @

  render: ->
    $(@el).html(@template())
    listElement = @$('ul')
    listElement.empty()
    for program in @collection.models
      programView = new Spinoff.Views.AvailableProgramView(model: program)
      listElement.append programView.render().el
    @

class Spinoff.Views.AvailableProgramView extends Backbone.View
  template: JST["backbone/templates/available_program"]

  events:
    "click .buy": "buy"
  initialize: ->
    @model.bind 'change', @render, @

  render: ->
    $(@el).html(@template(program: @model))
    @

  buy: (e) ->
    e.preventDefault()
    @model.set(company_id: company.get("id"))
    @model.save()
    $(@el).remove()
    @
