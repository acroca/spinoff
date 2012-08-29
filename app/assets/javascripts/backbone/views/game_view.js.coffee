Spinoff.Views.Homes ||= {}

class Spinoff.Views.GameView extends Backbone.View
  el: '#game'

  initialize: (options) ->
    availablePrograms = new Spinoff.Collections.ProgramsCollection()
    @subviews = [
      new Spinoff.Views.CompanyDetailView      model: company
      new Spinoff.Views.AvailableProgramsView  collection: availablePrograms
    ]
  render: ->
    $(@el).empty()
    $(@el).append subview.render().el for subview in @subviews
    @
