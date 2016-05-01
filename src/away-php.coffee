# Bypass away.php, see #3.

module.exports =

  defineSettings: ->
    "common.awayPhp":
      defaultValue: on
      onChange: ->


  run: ->
    # New <a> elements inserted by VK scripts may contain inline onclick handler:
    # `return goAway('url', {}, event);`
    # These elements also have the href set as below, so let's ignore this case
    # and fall through to the next case below.
    window.goAway = ->

    # <a> elements returned from server just have href: "away.php?to=url",
    # where url is uri-encoded.
    window.document.addEventListener "mousedown", ( event ) ->
      if event.target.matches "a[href^='/away.php']"
        href = event.target.href.match( /to=(.*)/ )[ 1 ]
        cp1251 = require "@vk-x/cp1251"
        decodedHref = cp1251.decode href
        event.target.href = decodedHref
