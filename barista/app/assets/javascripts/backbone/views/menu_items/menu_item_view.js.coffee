Barista.Views.MenuItems ||= {}

class Barista.Views.MenuItems.MenuItemView extends Backbone.View
  template: JST["backbone/templates/menu_items/menu_item"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
