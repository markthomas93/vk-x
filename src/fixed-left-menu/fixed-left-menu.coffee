# Fix menu on the page so it doesn't scroll out of view, see #6.

inject = require "@vk-x/inject"

# `updateLeftMenu` function is responsible for changing inline styles of
# the left menu. Overwrite it with an empty function so when the event handler
# calls it, nothing happens.
inject "window.updateLeftMenu = function() {}", true