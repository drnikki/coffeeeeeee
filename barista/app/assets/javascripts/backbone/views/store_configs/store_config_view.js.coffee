Barista.Views.StoreConfigs ||= {}

class Barista.Views.StoreConfigs.StoreConfigView extends Backbone.View
  template: JST["backbone/templates/store_configs/store_config"]

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
