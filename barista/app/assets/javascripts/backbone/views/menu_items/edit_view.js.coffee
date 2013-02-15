Barista.Views.MenuItems ||= {}

class Barista.Views.MenuItems.EditView extends Backbone.View
  template: JST["backbone/templates/menu_items/edit"]

  events:
    "submit #edit-menu_item": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (menu_item) =>
        @model = menu_item
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
