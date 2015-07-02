class AuthHelper
  @calculateHash: (timestamp, url, token) ->
    str = [timestamp, url, token].join(';')
    CryptoJS.SHA256(str).toString(CryptoJS.enc.Hex)
  @authHeader: (uri) ->
    timestamp = new Date().getTime()
    url = @url(uri)
    console.log(url)
    token = localStorage.getItem('token')
    client_id = localStorage.getItem('client_id')
    hash = @calculateHash(timestamp, url, token)
    [client_id, timestamp, hash].join(';')
  @url: (uri) ->
    window.location.origin + uri

Ember.$.ajaxPrefilter (options, oriOpt, jqXHR) ->
  authHeader = AuthHelper.authHeader(options.url)
  jqXHR.setRequestHeader("Authorization", authHeader)
  return

#Frontend.ApplicationAdapter = DS.RESTAdapter.extend(
  #headers: (->
    #'Authorization': new AuthHelper().authHeader(@)
  #).property().volatile())
