class Spinoff.Routers.SpinoffRouter extends Backbone.Router
  initialize: (options) ->
    @view = new Spinoff.Views.GameView()

  routes:
    "game": "main"

  main: ->
    window.company.fetch
      success: =>
        @view.render()
