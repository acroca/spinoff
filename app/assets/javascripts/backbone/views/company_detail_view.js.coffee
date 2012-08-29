Spinoff.Views.Homes ||= {}

class Spinoff.Views.CompanyDetailView extends Backbone.View
  template: JST["backbone/templates/company_detail"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @
