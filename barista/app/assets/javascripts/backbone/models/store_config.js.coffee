class Barista.Models.StoreConfig extends Backbone.Model
  paramRoot: 'store_config'


class Barista.Collections.StoreConfigsCollection extends Backbone.Collection
  model: Barista.Models.StoreConfig
  url: '/store_configs'
