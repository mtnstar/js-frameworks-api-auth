Frontend.ApplicationController = Ember.Controller.extend
  actions:
    logout: ()->
      Ember.$.get('/sessions/destroy')
      localStorage.removeItem('token')
      localStorage.removeItem('client_id')
      @transitionTo('session')
