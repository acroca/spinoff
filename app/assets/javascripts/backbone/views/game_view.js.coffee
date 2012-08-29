Spinoff.Views.Homes ||= {}

class Spinoff.Views.GameView extends Backbone.View
  el: '#game'

  initialize: (options) ->
    @subviews = [
      new Spinoff.Views.Homes.CompanyDetailView      model: company
    ]
  render: ->
    $(@el).empty()
    $(@el).append subview.render().el for subview in @subviews
    @
