class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  initialize: ->
    slotsCollection.bind 'sync', @addSlot, @

  addSlot: (slot) ->
    slotView = new Spinoff.Views.SlotView(model: slot)
    @$(".slot-#{slot.get('day')}-#{slot.get('time')}").
      html(slotView.render().el).
      removeClass('empty-slot')

  events:
    "drop .empty-slot": "createSlot"

  render: ->
    rendered = @template
      days: [currentDay...(currentDay+3)]
      times: [0..11]
      programs: company.programs.models
    $(@el).html(rendered)

    @$("[data-day='#{currentDay}']").each ->
      slot = $(this)
      if parseInt(slot.data("time"), 10) <= currentTime
        slot.
          addClass('past').
          removeClass('empty-slot').
          empty().
          attr('dropable', undefined)


    for slot in slotsCollection.models
      @addSlot(slot)

    @$("[draggable]").bind "dragstart", (e) ->
      e.originalEvent.dataTransfer.setData('product_id', $(e.target).data('program-id'))
      e.data = e.target

    @$(".empty-slot").
      bind("dragover", (e) -> (e.preventDefault() if (e.preventDefault))).
      bind("dragenter", -> (false))

    @

  createSlot: (e)->
    program_id = parseInt(e.originalEvent.dataTransfer.getData("product_id"), 10)
    slotCell = $(e.target)
    slotAttrs =
      day: slotCell.data('day')
      time: slotCell.data('time')
      program_id: program_id
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

