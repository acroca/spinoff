class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  initialize: ->
    slotsCollection.bind 'sync', @addSlot, @
    configVariables.bind 'change', @render, @

  addSlot: (slot) ->
    slotView = new Spinoff.Views.SlotView(model: slot)
    @$(".slot-#{slot.get('day')}-#{slot.get('time')}").
      html(slotView.render().el).
      removeClass('empty-slot')

  events:
    "click .set-slot": "openSlotModal"
    "click .select-program": "createSlot"

  render: ->
    today = configVariables.get("day")
    rendered = @template
      days: [today...(today+3)]
      times: [0..11]
      programs: company.programs.models
    $(@el).html(rendered)

    @$("[data-day='#{today}']").each ->
      $slot = $(this)
      if parseInt($slot.data("time"), 10) <= configVariables.get("time")
        $slot.
          addClass('past').
          removeClass('empty-slot').
          empty()

    @$("[data-time-tooltip]").each ->
      $element = $(this)
      time = $element.data("time-tooltip")
      title = _.map configVariables.get("genresByTime")[time], (k, v) ->
        percent = parseInt((k*100), 10)
        "#{percent}% #{v}"
      $element.find("i").tooltip
        title: title.join('<br/>')
        html: true
        placement: 'right'
        trigger: 'hover'


    for slot in slotsCollection.models
      @addSlot(slot)

    @

  openSlotModal: (e) ->
    cell = $(e.target).parents('.slot')
    @selectedCell =
      day: cell.data("day")
      time: cell.data("time")

    $("#programsModal").modal
      show: true

  createSlot: (e)->
    slotAttrs =
      day: @selectedCell.day
      time: @selectedCell.time
      program_id: $(e.target).data("program-id")
    slot = slotsCollection.create slotAttrs,
      error: (slot,response) ->
        errors = JSON.parse(response.responseText)
        alert("Wrong slot") if errors.time
        slotsCollection.remove(slot)

class Spinoff.Views.SlotView extends Backbone.View
  template: JST["backbone/templates/slot"]

  render: ->
    content = $(@template(slot: @model))
    $(@el).html(content)
    @

