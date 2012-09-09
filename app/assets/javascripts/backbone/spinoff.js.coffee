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
  window.company = new Spinoff.Models.Company(
    $game.data('user-company-json'),
    $game.data('user-company-programs-json')
  )
  gameView = new Spinoff.Views.GameView()
  gameView.render()
  router = new Spinoff.Routers.SpinoffRouter(gameView: gameView)
  Backbone.history.start({root: '/game'})

  window.genresByTime = $game.data('genres-by-time')
  window.currentDay = $game.data('current-day')
  window.currentTime = $game.data('current-time')
