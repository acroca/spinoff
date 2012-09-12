class Spinoff.Models.Program extends Backbone.Model
  urlRoot: "/api/v1/programs"
  paramRoot: 'program'

  initialize: (options) ->
    @popularityPercent = parseInt(options.popularity,10)/10.0

  defaults:
    name: null
    available: null
    genre: null
    type: null
    price: null
    popularity: null
    company_id: null


class Spinoff.Collections.ProgramsCollection extends Backbone.Collection
  model: Spinoff.Models.Program
  url: '/api/v1/programs'

  comparator: (program) ->
    program.get("price")

  programBought: (programId) ->
    program = @get(programId)
    @remove(program) if program

window.programsCollection = new Spinoff.Collections.ProgramsCollection()
