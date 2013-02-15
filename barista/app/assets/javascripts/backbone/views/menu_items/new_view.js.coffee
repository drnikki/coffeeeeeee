Barista.Views.MenuItems ||= {}

class Barista.Views.MenuItems.NewView extends Backbone.View
  template: JST["backbone/templates/menu_items/new"]

  events:
    "submit #new-menu_item": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (menu_item) =>
        @model = menu_item
        window.location.hash = "/#{@model.id}"

      error: (menu_item, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
