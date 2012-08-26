class Spinoff.Models.Company extends Backbone.Model
  paramRoot: 'company'
  url: '/api/v1/company'
  defaults:
    name: null
    money: null

window.company = new Spinoff.Models.Company()
