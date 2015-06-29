Frontend.ApplicationController = Ember.Controller.extend
  actions:
    logout: ()->
      localStorage.removeItem('token')
      localStorage.removeItem('client_id')
      @transitionTo('session')
