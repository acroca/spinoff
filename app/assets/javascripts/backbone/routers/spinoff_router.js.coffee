class Spinoff.Routers.SpinoffRouter extends Backbone.Router
  initialize: (options) ->
    @view = new Spinoff.Views.GameView()

  routes:
    "": "main"
    "available-programs": "availablePrograms"

  main: ->
    @view.render() unless @rendered
    @rendered = true

  availablePrograms: ->
    @view.availablePrograms()
    @main()
