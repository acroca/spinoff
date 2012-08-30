Spinoff.Views.Homes ||= {}

class Spinoff.Views.GameView extends Backbone.View
  template: JST["backbone/templates/game"]
  el: '#game'
  subviewEl: '#game-subview'

  events:
    "click .available-programs": "availablePrograms"

  initialize: (options) ->

  render: ->
    $(@el).empty()
    $(@el).html(@template(window.company.toJSON()))
    @

  resetSubview: ->
    @$(@subviewEl).html("Loading...")

  setSubview: (content) ->
    @$(@subviewEl).html(content)

  availablePrograms: ->
    @resetSubview()
    programsCollection.fetch
      success: =>
        view = new Spinoff.Views.AvailableProgramsView
          collection: programsCollection
        @setSubview(view.render().el)
