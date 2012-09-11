class Spinoff.Models.Slot extends Backbone.Model
  urlRoot: "/api/v1/slots"
  paramRoot: 'slot'

  initialize: (options)->
    configVariables.bind 'change', @fetchIfAffected, @
    @program = company.programs.get(options.program_id)
    super(options)

  defaults:
    program_id: null
    audience: null
    day: null
    time: null

  fetchIfAffected: (config) ->
    if config.previous("day") == @get("day") && config.previous("time") == @get("time")
      @fetch()


class Spinoff.Collections.SlotsCollection extends Backbone.Collection
  model: Spinoff.Models.Slot
  url: '/api/v1/slots'

  comparator: (slot) ->
    slot.get("day") * 100 + slot.get("time")

window.slotsCollection = new Spinoff.Collections.SlotsCollection()
