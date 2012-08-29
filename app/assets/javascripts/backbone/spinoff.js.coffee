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
  window.company = new Spinoff.Models.Company($('#game').data('user-company-json'))
  router = new Spinoff.Routers.SpinoffRouter()
  Backbone.history.start({root: '/game'})
