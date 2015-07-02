Frontend.SessionController = Ember.Controller.extend
  actions:
    login: ()->
      data = @getProperties('username', 'password')
      Ember.$.post('/sessions/create', data).then((response)=>
        token = response.access_token
        client_id = response.client_id
        localStorage.setItem('token', token)
        localStorage.setItem('client_id', client_id)
        @transitionTo('/')
      )
