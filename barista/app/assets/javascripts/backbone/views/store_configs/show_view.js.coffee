Barista.Views.StoreConfigs ||= {}

class Barista.Views.StoreConfigs.ShowView extends Backbone.View
  template: JST["backbone/templates/store_configs/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
