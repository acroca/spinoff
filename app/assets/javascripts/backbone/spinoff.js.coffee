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

Backbone.old_sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  new_options = _.extend(
    beforeSend: (xhr) ->
      token = $("#game").data("user-token")
      xhr.setRequestHeader('X-CSRF-Token', token) if token
  , options)
  Backbone.old_sync(method, model, options)


$ ->
  $ = jQuery
  window.company = new Spinoff.Models.Company(id: $('#game').data('user-company-id'))
  router = new Spinoff.Routers.SpinoffRouter()
  Backbone.history.start({pushState:true})
#    success: ->
#      @view = new Spinoff.Views.Homes.CompanyDetailView(object: window.company)
#      $("#game").html(@view.render().el)
