class Spinoff.Models.Slot extends Backbone.Model
  urlRoot: "/api/v1/slots"
  paramRoot: 'slot'

  initialize: (options)->
    @program = company.programs.where(id: options.program_id)[0]
    super(options)

  defaults:
    program_id: null
    day: null
    time: null

class Spinoff.Collections.SlotsCollection extends Backbone.Collection
  model: Spinoff.Models.Slot
  url: '/api/v1/slots'

  comparator: (slot) ->
    slot.get("day") * 100 + slot.get("time")

window.slotsCollection = new Spinoff.Collections.SlotsCollection()
