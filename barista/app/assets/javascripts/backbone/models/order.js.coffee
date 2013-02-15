class Barista.Models.Order extends Backbone.Model
  paramRoot: 'order'


class Barista.Collections.OrdersCollection extends Backbone.Collection
  model: Barista.Models.Order
  url: '/orders'
