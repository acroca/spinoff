class Spinoff.Routers.SpinoffRouter extends Backbone.Router
  initialize: (options) ->
    @view = options.gameView

  routes:
    "available-programs": "availablePrograms"
    "available-ad-contracts": "availableAdContracts"
    "my-programs": "myPrograms"
    "my-ad-contracts": "myAdContracts"
    "schedule": "schedule"

  availablePrograms: ->
    @view.availablePrograms()

  availableAdContracts: ->
    @view.availableAdContracts()

  myPrograms: ->
    @view.myPrograms()

  myAdContracts: ->
    @view.myAdContracts()

  schedule: ->
    @view.schedule()
