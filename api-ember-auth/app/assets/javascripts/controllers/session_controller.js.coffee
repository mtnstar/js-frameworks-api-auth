Frontend.SessionController = Ember.Controller.extend
  actions:
    login: ()->
      localStorage.setItem('token', 'abc')
      @transitionTo('/')
