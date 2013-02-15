class Barista.Models.Menu_Item extends Backbone.Model
  paramRoot: "menu_item"

class Barista.Collections.Menu_ItemsCollection extends Backbone.Collection
  model: Barista.Models.Menu_Item
  url: '/menu_items'
