Barista.Views.StoreConfigs ||= {}

class Barista.Views.StoreConfigs.EditView extends Backbone.View
  template: JST["backbone/templates/store_configs/edit"]

  events:
    "submit #edit-store_config": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (store_config) =>
        @model = store_config
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
