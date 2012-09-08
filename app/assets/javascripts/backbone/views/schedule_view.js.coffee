class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  initialize: ->
    slotsCollection.bind 'add', @addSlot, @

  addSlot: (slot) ->
    slotView = new Spinoff.Views.SlotView(model: slot)
    @$(".slot-#{slot.get('day')}-#{slot.get('time')}").html(slotView.render().el)

  events:
    "submit form": "createSlot"

  render: ->
    currentDay = $("#game").data('current-day')
    rendered = @template
      days: [currentDay...(currentDay+5)]
      times: [0..11]
    $(@el).html(rendered)
    @loadPrograms()

    for slot in slotsCollection.models
      @addSlot(slot)

    @

  loadPrograms: ->
    selectElement = @$('form select')
    for program in company.programs.models
      selectElement.append($("<option>", value: program.get("id")).text(program.get("name")))

  createSlot: (e) ->
    e.preventDefault()
    form = @$('form')
    slotAttrs =
      day: parseInt(form.find('[name=day]').val())
      time: parseInt(form.find('[name=time]').val())
      program_id: parseInt(form.find('[name=program_id]').val())
    slot = slotsCollection.create(slotAttrs)
    form[0].reset()
    false

class Spinoff.Views.SlotView extends Backbone.View
  template: JST["backbone/templates/slot"]

  render: ->
    content = $(@template(slot: @model))
    $(@el).html(content)
    @

