Spinoff.Views.Homes ||= {}

class Spinoff.Views.Homes.ShowCompanyView extends Backbone.View
  template: JST["backbone/templates/homes/show_company"]

  render: ->
    $(@el).html(@template())
    return this
