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
#
#Backbone.old_sync = Backbone.sync
#Backbone.sync = (method, model, options) ->
#  new_options = _.extend(
#    beforeSend: (xhr) ->
#      token = $("#game").data("user-token")
#      console.log(token)
#      xhr.setRequestHeader("auth_token", token) if token
#  , options)
#  Backbone.old_sync(method, model, options)
$.ajaxSetup
  headers:
    auth_token: $("#game").data("user-token")

$ ->
  $ = jQuery
  window.company = new Spinoff.Models.Company($('#game').data('user-company-json'))
  @view = new Spinoff.Views.GameView()
  @view.render()
