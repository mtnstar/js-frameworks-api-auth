Frontend.ApplicationController = Ember.Controller.extend
  actions:
    logout: ()->
      localStorage.removeItem('token')
      @transitionTo('session')
