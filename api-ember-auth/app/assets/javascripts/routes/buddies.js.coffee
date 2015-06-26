Frontend.BuddiesRoute = Ember.Route.extend({
  model:->
    @store.findAll 'buddy'
})
