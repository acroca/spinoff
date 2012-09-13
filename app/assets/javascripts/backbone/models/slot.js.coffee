class Spinoff.Models.Slot extends Backbone.Model
  urlRoot: "/api/v1/slots"
  paramRoot: 'slot'

  initialize: (options)->
    configVariables.bind 'change', @fetchIfAffected, @
    @setAssociations()
    super(options)

  change: ->
    @setAssociations()
    super()

  setAssociations: ->
    @program = company.programs.get(@get("program_id"))
    @adContract = company.adContracts.get(@get("ad_contract_id"))

  defaults:
    program_id: null
    ad_contract_id: null
    audience: null
    day: null
    time: null

  fetchIfAffected: (config) ->
    if config.previous("day") == @get("day") && config.previous("time") == @get("time")
      @fetch()

  isFuture: () ->
    today = configVariables.get("day")
    return true if @get("day") > today
    return false if @get("day") < today
    configVariables.get("time") < @get("time")


class Spinoff.Collections.SlotsCollection extends Backbone.Collection
  model: Spinoff.Models.Slot
  url: '/api/v1/slots'

  comparator: (slot) ->
    slot.get("day") * 100 + slot.get("time")

window.slotsCollection = new Spinoff.Collections.SlotsCollection()
