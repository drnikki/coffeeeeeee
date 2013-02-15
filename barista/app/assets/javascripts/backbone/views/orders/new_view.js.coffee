Barista.Views.Orders ||= {}

class Barista.Views.Orders.NewView extends Backbone.View
  template: JST["backbone/templates/orders/new"]

  events:
    "submit #new-order": "save"

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
      success: (order) =>
        @model = order
        window.location.hash = "/#{@model.id}"

      error: (order, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
