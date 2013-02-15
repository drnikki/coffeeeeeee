class Barista.Models.MenuItem extends Backbone.Model
  paramRoot: 'menu_item'

  defaults:

class Barista.Collections.MenuItemsCollection extends Backbone.Collection
  model: Barista.Models.MenuItem
  url: '/menu_items'
