Barista.Views.StoreConfigs ||= {}

class Barista.Views.StoreConfigs.IndexView extends Backbone.View
  template: JST["backbone/templates/store_configs/index"]

  initialize: () ->
    @options.storeConfigs.bind('reset', @addAll)

  addAll: () =>
    @options.storeConfigs.each(@addOne)

  addOne: (storeConfig) =>
    view = new Barista.Views.StoreConfigs.StoreConfigView({model : storeConfig})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(storeConfigs: @options.storeConfigs.toJSON() ))
    @addAll()

    return this
