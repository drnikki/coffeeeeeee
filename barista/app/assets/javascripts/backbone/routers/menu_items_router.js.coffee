class Barista.Routers.MenuItemsRouter extends Backbone.Router
  initialize: (options) ->
    @menuItems = new Barista.Collections.MenuItemsCollection()
    @menuItems.reset options.menuItems

  routes:
    "new"      : "newMenuItem"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newMenuItem: ->
    @view = new Barista.Views.MenuItems.NewView(collection: @menu_items)
    $("#menu_items").html(@view.render().el)

  index: ->
    @view = new Barista.Views.MenuItems.IndexView(menu_items: @menu_items)
    $("#menu_items").html(@view.render().el)

  show: (id) ->
    menu_item = @menu_items.get(id)

    @view = new Barista.Views.MenuItems.ShowView(model: menu_item)
    $("#menu_items").html(@view.render().el)

  edit: (id) ->
    menu_item = @menu_items.get(id)

    @view = new Barista.Views.MenuItems.EditView(model: menu_item)
    $("#menu_items").html(@view.render().el)
