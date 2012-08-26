Spinoff.Views.Homes ||= {}

class Spinoff.Views.Homes.CreateCompanyView extends Backbone.View
  template: JST["backbone/templates/homes/create_company"]

  render: ->
    $(@el).html(@template())
    return this

  events: 
    "click button[type='submit']": "submitForm"

  submitForm: ->
    company.set
      name: @.$("input[name='name']").val()
    company.save()
    false
