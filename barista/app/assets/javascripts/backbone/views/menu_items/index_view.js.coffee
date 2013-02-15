Barista.Views.MenuItems ||= {}

class Barista.Views.MenuItems.IndexView extends Backbone.View
  template: JST["backbone/templates/menu_items/index"]

  initialize: () ->
    @options.menuItems.bind('reset', @addAll)

  addAll: () =>
    @options.menuItems.each(@addOne)

  addOne: (menuItem) =>
    view = new Barista.Views.MenuItems.MenuItemView({model : menuItem})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(menuItems: @options.menuItems.toJSON() ))
    @addAll()

    return this
