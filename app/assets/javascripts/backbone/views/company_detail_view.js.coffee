class Spinoff.Views.CompanyDetailView extends Backbone.View
  template: JST["backbone/templates/company_detail"]

  initialize: ->
    company.bind 'change', @render, @

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @
