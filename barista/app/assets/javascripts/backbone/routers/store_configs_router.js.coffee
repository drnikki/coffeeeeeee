class Barista.Routers.StoreConfigsRouter extends Backbone.Router
  initialize: (options) ->
    @storeConfigs = new Barista.Collections.StoreConfigsCollection()
    @storeConfigs.reset options.storeConfigs

  routes:
    "new"      : "newStoreConfig"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newStoreConfig: ->
    @view = new Barista.Views.StoreConfigs.NewView(collection: @store_configs)
    $("#store_configs").html(@view.render().el)

  index: ->
    @view = new Barista.Views.StoreConfigs.IndexView(store_configs: @store_configs)
    $("#store_configs").html(@view.render().el)

  show: (id) ->
    store_config = @store_configs.get(id)

    @view = new Barista.Views.StoreConfigs.ShowView(model: store_config)
    $("#store_configs").html(@view.render().el)

  edit: (id) ->
    store_config = @store_configs.get(id)

    @view = new Barista.Views.StoreConfigs.EditView(model: store_config)
    $("#store_configs").html(@view.render().el)
