class Spinoff.Views.AvailableProgramsView extends Backbone.View
  template: JST["backbone/templates/available_programs"]

  initialize: ->
    @collection.bind 'reset', @render, @
    @collection.fetch()

  render: ->
    $(@el).html(@template(programs: @collection))
    @
