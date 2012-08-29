class Spinoff.Views.AvailableProgramsView extends Backbone.View
  template: JST["backbone/templates/available_programs"]

  initialize: ->
    @collection.bind 'reset', @render, @

  render: ->
    $(@el).html(@template(programs: @collection))
    @
