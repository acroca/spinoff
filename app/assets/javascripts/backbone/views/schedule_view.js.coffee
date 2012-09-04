class Spinoff.Views.ScheduleView extends Backbone.View
  template: JST["backbone/templates/schedule"]

  render: ->
    $(@el).html(@template())
    listElement = @$('table > tbody')
    listElement.empty()
    for program in @collection.models
      slotView = new Spinoff.Views.SlotView(model: program)
      listElement.append slotView.render().el
    @

class Spinoff.Views.SlotView extends Backbone.View
  template: JST["backbone/templates/slot"]
  tagName: 'tr'

  render: ->
    content = $(@template(slot: @model))
    $(@el).html(content)
    @
