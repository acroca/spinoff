class Spinoff.Models.Company extends Backbone.Model
  urlRoot: "/api/v1/companies"
  paramRoot: 'company'

  defaults:
    name: null
    money: null

class Spinoff.Collections.CompaniesCollection extends Backbone.Collection
  model: Spinoff.Models.Company
  url: '/api/v1/companies'


