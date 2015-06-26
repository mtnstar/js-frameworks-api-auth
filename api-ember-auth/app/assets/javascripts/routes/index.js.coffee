Frontend.IndexRoute = Ember.Route.extend
  beforeModel:->
    @transitionTo('/buddies')
