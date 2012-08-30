class Spinoff.Models.Program extends Backbone.Model
  urlRoot: "/api/v1/programs"
  paramRoot: 'program'

  defaults:
    name: null
    available: null
    type: null
    company_id: null

class Spinoff.Collections.ProgramsCollection extends Backbone.Collection
  model: Spinoff.Models.Program
  url: '/api/v1/programs'

window.programsCollection = new Spinoff.Collections.ProgramsCollection()
