#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Spinoff =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

old_sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  options.username = "albert@acroca.com"
  options.password = "albertpassword"
  old_sync(method, model, options)



$ ->
  $ = jQuery
  Backbone.history.start();
