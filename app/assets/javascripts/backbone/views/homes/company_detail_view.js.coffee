Spinoff.Views.Homes ||= {}

class Spinoff.Views.Homes.CompanyDetailView extends Backbone.View
  template: JST["backbone/templates/homes/company_detail"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @
