class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  events:
    "submit form": "createSlot"

  render: ->
    currentDay = $("#game").data('current-day')
    $(@el).html(@template(days: [currentDay...(currentDay+5)]))
    @loadPrograms()

    for slotsContainer in @$(".slots-container")
      $slotsContainer = $(slotsContainer)
      day = $slotsContainer.data('day')
      for time in [0..11]
        view = new Spinoff.Views.SlotView(day: day, time: time, collection: slotsCollection)
        $slotsContainer.append view.render().el
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
  tagName: 'div'
  className: 'row'

  initialize: (options) ->
    @day = options.day
    @time = options.time
    @collection.bind 'change', @checkAndRender, @
    @model = @collection.where(day: @day, time: @time)[0]
    super(options)

  checkAndRender: ->
    newModel = @collection.where(day: @day, time: @time)[0]
    if newModel && newModel != @model
      @model = newModel
      @render()
  render: ->
    content = $(@template(slot: @model, day: @day, time: @time))
    $(@el).html(content)
    @

