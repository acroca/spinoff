#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Spinoff =
  Models:
    {}
  Collections:
    {}
  Routers:
    {}
  Views:
    {}

$.ajaxSetup
  headers:
    auth_token: $("#game").data("user-token")

$ ->
  $ = jQuery
  $game = $("#game")
  window.configVariables = new Spinoff.Models.ConfigVariables $game.data('current-configuration')

  window.company = new Spinoff.Models.Company(
    $game.data('user-company-json'),
    $game.data('user-company-programs-json'),
    $game.data('user-company-ad-contracts-json')
  )
  gameView = new Spinoff.Views.GameView()
  gameView.render()
  router = new Spinoff.Routers.SpinoffRouter(gameView: gameView)
  Backbone.history.start({root: '/game'})


  pusher = new Pusher($game.data('pusher-key'))
  channel = pusher.subscribe('spinoff')
  channel.bind 'force-reload', () ->
    alert("Please reload the page.")

  channel.bind 'game-tick', (data) ->
    window.configVariables.set
      day: data.day
      time: data.time

  channel.bind 'program-bought', (programId) ->
    programsCollection.programBought(programId)
