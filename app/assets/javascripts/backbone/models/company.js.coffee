class Spinoff.Models.Company extends Backbone.Model
  urlRoot: "/api/v1/companies"
  paramRoot: 'company'

  initialize: (options, programs) ->
    @programs = new Spinoff.Collections.ProgramsCollection(programs)
    @programs.url = "/api/v1/companies/#{@.get('id')}/programs"
    super(options)

  defaults:
    name: null
    money: null

class Spinoff.Collections.CompaniesCollection extends Backbone.Collection
  model: Spinoff.Models.Company
  url: '/api/v1/companies'


