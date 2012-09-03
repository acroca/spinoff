class Spinoff.Views.CompanyDetailView extends Backbone.View
  template: JST["backbone/templates/company_detail"]

  initialize: ->
    @model.bind 'change', @render, @
    @model.programs.bind 'add remove', @render, @

  render: ->
    $(@el).html(@template(program: @model))
    @

