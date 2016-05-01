api = require "./api"
pubsub = require "pubsub-js"

cache = {}

settings =

  on: ( topic, listener ) ->
    pubsub.subscribe "settings.#{topic}", ( msg, data ) ->
      listener data


  trigger: ( topic, data ) ->
    pubsub.publish "settings.#{topic}", data


  add: ( newSettings ) ->
    for own key, { defaultValue, onChange } of newSettings
      cache[ key ] ?= defaultValue
      if onChange
        @on "set.#{key}", onChange

    return


  fetchLocal: ->
    new Promise ( resolve ) ->
      parsed = JSON.parse ( window.localStorage[ "vkx-settings" ] ? "{}" )
      for own key, value of parsed
        if cache[ key ] isnt value
          cache[ key ] = value
          settings.trigger "set.#{key}", { key, value }

      resolve cache


  saveLocal: ->
    new Promise ( resolve ) ->
      window.localStorage[ "vkx-settings" ] = JSON.stringify cache
      resolve cache


  fetchRemote: ->
    api.ready.then ->
      api.storage.get key: "settings"
    .then ( settings = {}) ->
      cache = settings


  saveRemote: ->
    api.storage.set key: "settings", value: cache


  get: ( key ) ->
    cache[ key ]


  getAll: ->
    cache


  set: ( key, value ) ->
    cache[ key ] = value
    settings.trigger "set.#{key}", { key, value }

    @saveLocal()


module.exports = settings
