class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  events:
    "submit form": "createSlot"

  initialize: ->
    slotsCollection.bind 'change', @render, @

  render: ->
    $(@el).html(@template())
    @loadPrograms()
    listElement = @$('table > tbody')
    listElement.empty()
    for program in @collection.models
      slotView = new Spinoff.Views.SlotView(model: program)
      listElement.append slotView.render().el
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
    false

class Spinoff.Views.SlotView extends Backbone.View
  template: JST["backbone/templates/slot"]
  tagName: 'tr'

  render: ->
    content = $(@template(slot: @model))
    $(@el).html(content)
    @
