class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  initialize: ->
    slotsCollection.bind 'sync', @addSlot, @
    configVariables.bind 'change', @moveCurrentTime, @

  addSlot: (slot) ->
    slotView = new Spinoff.Views.SlotView(model: slot)
    @$(".slot-#{slot.get('day')}-#{slot.get('time')}").
      html(slotView.render().el).
      removeClass('empty-slot')

  events:
    "click .set-slot": "openSlotModal"
    "click .select-program": "createSlot"
    "click .set-ad-contract": "openAdModal"
    "click .select-ad-contract": "createAd"

  render: ->
    today = configVariables.get("day")
    rendered = @template
      days: [today...(today + 3)]
      times: [0..11]
      programs: company.programs.models
      adContracts: company.adContracts.models
    $(@el).html(rendered)

    @moveCurrentTime()
    @$("[data-time-tooltip]").each ->
      $element = $(this)
      time = $element.data("time-tooltip")
      title = _.map configVariables.get("genresByTime")[time], (k, v) ->
        percent = parseInt((k * 100), 10)
        "#{percent}% #{v}"
      $element.find("i").tooltip
        title: title.join('<br/>')
        html: true
        placement: 'right'
        trigger: 'hover'


    for slot in slotsCollection.models
      @addSlot(slot)

    @

  moveCurrentTime: ->
    today = configVariables.get("day")

    @$("[data-day]").each ->
      $slot = $(this)
      currentTime = configVariables.get("time")
      slotDay = parseInt($slot.data("day"), 10)
      slotTime = parseInt($slot.data("time"), 10)

      if slotDay < today || (slotDay == today && slotTime <= currentTime)
        $slot.empty().removeClass('empty-slot') if $slot.hasClass("empty-slot")
        if slotTime == currentTime && slotDay == today
          $slot.addClass('current')
        else
          $slot.addClass('past').removeClass("current")

  openSlotModal: (e) ->
    cell = $(e.target).parents('.slot')
    @selectedCell =
      day: cell.data("day")
      time: cell.data("time")

    $("#programsModal").modal
      show: true
  openAdModal: (e) ->
    cell = $(e.target).parents('.slot')
    @selectedCell =
      day: cell.data("day")
      time: cell.data("time")

    $("#adContractsModal").modal
      show: true

  createSlot: (e)->
    slotAttrs =
      day: @selectedCell.day
      time: @selectedCell.time
      program_id: $(e.target).data("program-id")
    slot = slotsCollection.create slotAttrs,
      error: (slot, response) ->
        errors = JSON.parse(response.responseText)
        alert("Wrong slot") if errors.time
        slotsCollection.remove(slot)

  createAd: (e) ->
    slot = slotsCollection.where(day: @selectedCell.day, time: @selectedCell.time)[0]
    slot.set(ad_contract_id: $(e.target).data("ad-contract-id"))
    slot.save()

class Spinoff.Views.SlotView extends Backbone.View
  template: JST["backbone/templates/slot"]

  initialize: () ->
    @model.bind 'change', @render, @

  render: ->
    content = $(@template(slot: @model))
    $(@el).html(content)
    @

