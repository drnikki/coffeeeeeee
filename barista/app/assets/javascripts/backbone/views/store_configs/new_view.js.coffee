Barista.Views.StoreConfigs ||= {}

class Barista.Views.StoreConfigs.NewView extends Backbone.View
  template: JST["backbone/templates/store_configs/new"]

  events:
    "submit #new-store_config": "save"

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
      success: (store_config) =>
        @model = store_config
        window.location.hash = "/#{@model.id}"

      error: (store_config, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
