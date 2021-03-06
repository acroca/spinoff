Spinoff.Views.Homes ||= {}

class Spinoff.Views.GameView extends Backbone.View
  template: JST["backbone/templates/game"]
  el: '#game'
  subviewEl: '#game-subview'

  initialize: (options) ->
    @companyDetailView = new Spinoff.Views.CompanyDetailView
      model: company

  render: ->
#    $(@el).empty()
    $(@el).html(@template(company: window.company))
    @$('.company-detail').html(@companyDetailView.render().el)
    @

  resetSubview: ->
    @$(@subviewEl).html("Loading...")

  setSubview: (content) ->
    @$(@subviewEl).html(content)

  availablePrograms: ->
    @resetSubview()
    programsCollection.fetch
      success: =>
        view = new Spinoff.Views.AvailableProgramsView
          collection: programsCollection
        @setSubview(view.render().el)


  availableAdContracts: ->
    @resetSubview()
    adContractsCollection.fetch
      success: =>
        view = new Spinoff.Views.AvailableAdContractsView
          collection: adContractsCollection
        @setSubview(view.render().el)


  myPrograms: ->
    @resetSubview()
    view = new Spinoff.Views.MyProgramsView
      collection: company.programs
    @setSubview(view.render().el)

  myAdContracts: ->
    @resetSubview()
    view = new Spinoff.Views.MyAdContractsView
      collection: company.adContracts
    @setSubview(view.render().el)

  schedule: ->
    @resetSubview()
    slotsCollection.fetch
      success: =>
        view = new Spinoff.Views.ScheduleView
          collection: slotsCollection
        @setSubview(view.render().el)
