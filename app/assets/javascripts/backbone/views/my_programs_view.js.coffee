class Spinoff.Views.MyProgramsView extends Backbone.View
  template: JST["backbone/templates/my_programs"]

  render: ->
    $(@el).html(@template())
    listElement = @$('table > tbody')
    listElement.empty()
    for program in @collection.models
      programView = new Spinoff.Views.MyProgramView(model: program)
      listElement.append programView.render().el
    @

class Spinoff.Views.MyProgramView extends Backbone.View
  template: JST["backbone/templates/my_program"]
  tagName: 'tr'

  render: ->
    content = $(@template(program: @model))
    $(@el).html(content)
    @
