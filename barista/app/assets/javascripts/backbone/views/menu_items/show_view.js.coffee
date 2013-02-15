Barista.Views.MenuItems ||= {}

class Barista.Views.MenuItems.ShowView extends Backbone.View
  template: JST["backbone/templates/menu_items/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
