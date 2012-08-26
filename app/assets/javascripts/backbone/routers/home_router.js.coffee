class Spinoff.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "": "home"
  
  createCompany: ->
    @view = new Spinoff.Views.Homes.CreateCompanyView()
    $("#content").html(@view.render().el)

  showCompany: ->
    @view = new Spinoff.Views.Homes.ShowCompanyView()
    $("#content").html(@view.render().el)

  home: ->
    company.fetch
      success: ->
        homesRouter.showCompany()
      error: ->
        homesRouter.createCompany()

window.homesRouter = new Spinoff.Routers.HomesRouter()