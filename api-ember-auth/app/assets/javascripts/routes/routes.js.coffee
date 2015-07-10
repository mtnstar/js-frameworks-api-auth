Frontend.IndexRoute = Ember.Route.extend
  beforeModel:->
    @transitionTo('/buddies')

Frontend.AuthenticatedRoute = Ember.Route.extend
  beforeModel:->
    token = localStorage.getItem('token')
    if !token
      @transitionTo('/session')

Frontend.BuddiesRoute = Frontend.AuthenticatedRoute.extend
  model:->
    @store.findAll 'buddy'

Frontend.SessionRoute = Ember.Route.extend
  beforeModel:->
    token = localStorage.getItem('token')
    client_id = localStorage.getItem('client_id')
    if token && client_id
      @transitionTo('/')
