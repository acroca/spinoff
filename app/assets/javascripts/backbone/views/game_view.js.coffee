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


  myPrograms: ->
    @resetSubview()
    view = new Spinoff.Views.MyProgramsView
      collection: company.programs
    @setSubview(view.render().el)
