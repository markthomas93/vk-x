# Driver API

- [`vk.getAuthUrl([appId=vk.appId], [permissions=[]], [options={}])`](#vkgetauthurlappidvkappid-permissions-options)
- [`vk.authWebsite([appId=vk.appId], [permissions=[]], [windowStyle="popup"], [callback=noop])`](#vkauthwebsiteappidvkappid-permissions-windowstylepopup-callbacknoop)
- [`vk.getAccessToken([appId=vk.appId], [callback=noop])`](#vkgetaccesstokenappidvkappid-callbacknoop)
- [`vk.method(methodName, params, [callback=noop])`](#vkmethodmethodname-params-callbacknoop)
- [Aliases](#aliases)


## `vk.getAuthUrl([appId=vk.appId], [permissions=[]], [options={}])`

Suggests a URL for app authentication. See [Client Application Authorization](https://vk.com/dev/auth_mobile).

This method is an optional utility. Skip it if you use a different auth flow or prefer to create a custom auth URL.

#### Since: 0.1.0

##### Arguments

1. **`[appId=vk.appId]`** *(number|string)*: ID of your VK application. See [My Applications](https://vk.com/apps?act=manage).
1. **`[permissions=[]]`** *(Array)*: Permissions for your VK application. See [My Applications](https://vk.com/apps?act=manage).
1. **`[options.version="5.53"]`** *(string)*: API version to use when calling api.vk.com. `vk.version` is set to this value and used in other methods.
1. **`[options.redirectUrl="https://oauth.vk.com/blank.html"]`** *(string)*: URL to which the auth window will be redirected after authentication.
1. **`[options.windowStyle="popup"]`** *(string)*: Auth window style. See [OAuth Authorization Dialog](https://vk.com/dev/oauth_dialog).

##### Returns

*(string)*: Returns a URL to use in `window.open()`.

##### Examples

```JavaScript

vk.getAuthUrl("12345", ["audio", "photos"], {version: "4.10"})
// "https://oauth.vk.com/authorize?client_id=12345&scope=audio,photos&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&display=popup&v=4.10&response_type=token"

vk.getAuthUrl("12345", ["friends"], vk.version, {windowStyle: "page"})
// "https://oauth.vk.com/authorize?client_id=12345&scope=friends&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&display=page&v=5.53&response_type=token"

vk.appId = "12345"
vk.getAuthUrl()
// "https://oauth.vk.com/authorize?client_id=12345&scope=&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&display=popup&v=5.53&response_type=token"

```


## `vk.authWebsite([appId=vk.appId], [permissions=[]], [windowStyle="popup"], [callback=noop])`

Authenticates an app on a website via a popup and obtains an access token.
See [Client Application Authorization](https://vk.com/dev/auth_mobile) and [Open API](https://vk.com/dev/openapi).

Doesn't open a popup if the app is already authenticated. You don't need to call `vk.getAccessToken()` before `vk.authWebsite()` to check this.

This method is an optional utility. Skip it if you use a different auth flow or prefer to obtain an access token yourself.

This method sets `vk.accessToken` automatically. If you skip this method, set `vk.accessToken` to your token before using the API.

#### Since: 0.3.0

##### Arguments

1. **`[appId=vk.appId]`** *(number|string)*: ID of your VK application. See [My Applications](https://vk.com/apps?act=manage).
1. **`[permissions=[]]`** *(Array)*: Permissions for your VK application. See [My Applications](https://vk.com/apps?act=manage).
1. **`[options.windowStyle="popup"]`** *(string)*: Auth window style. See [OAuth Authorization Dialog](https://vk.com/dev/oauth_dialog).
1. **`[callback=noop]`** *(Function|null)*: optional callback with signature `callback(accessToken)`.

##### Returns

*(Promise)*: Resolves with an access token to use when calling API.

##### Examples

```JavaScript

vk.authWebsite("12345").then(function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

vk.authWebsite("12345", ["audio", "photos"], "page", function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

vk.appId = "12345"
vk.authWebsite().then(function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

```


## `vk.getAccessToken([appId=vk.appId], [callback=noop])`

Obtains an access token from `https://login.vk.com/` after the app has been authenticated.
See [Client Application Authorization](https://vk.com/dev/auth_mobile) and [Open API](https://vk.com/dev/openapi).

This method is an optional utility. Skip it if you use a different auth flow or prefer to obtain an access token yourself.

This method sets `vk.accessToken` automatically. If you skip this method, set `vk.accessToken` to your token before using the API.

#### Since: 0.2.0

##### Arguments

1. **`[appId=vk.appId]`** *(number|string)*: ID of your VK application. See [My Applications](https://vk.com/apps?act=manage).
1. **`[callback=noop]`** *(Function|null)*: optional callback with signature `callback(accessToken)`.

##### Returns

*(Promise)*: Resolves with an access token to use when calling API.

##### Examples

```JavaScript

vk.getAccessToken("12345").then(function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

vk.getAccessToken("12345", function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

vk.appId = "12345"
vk.getAccessToken().then(function(token) {
  console.log(token) // "6a7ccc59b984856dc1424ef..."
})

```


## `vk.method(methodName, [params={}], [callback=noop])`

Calls the specified API method and returns its result. See [API Requests](https://vk.com/dev/api_requests).

Supports both callbacks and promises.

This method uses `vk.request()` for performing actual network requests. Override `vk.request` to change the behavior of this library.

#### Since: 0.1.0

##### Arguments

1. **`methodName`** *(string)*: the name of the API method. See [API Methods](https://vk.com/dev/methods).
1. **`[params={}]`** *(Object)*: Parameters to pass to the API.
1. **`[callback=noop]`** *(Function|null)*: optional callback with signature `callback(error, response)`.

##### Returns

*(Promise)*: Resolves with the result from the API or rejects with the error if it exists.

##### Examples

```JavaScript

vk.accessToken = "your-token"

vk.method("users.get", {fields: "online"}).then(function(result) {
  console.log(result.online)

}, function(error) {
  console.log(error)
})

vk.method("users.get", {fields: "online"}, function(error, result) {
  console.log(error || result.online)
})

```


## Aliases

The `vk` object has built-in aliases for most API methods. Each alias is a transparent wrapper around `vk.method`.

For an exhaustive list of available aliases please refer to [`src/method-list.json`](../src/method-list.json) and
[`src/client-method-list.json`](../src/client-method-list.json).

#### Since: 0.1.0

##### Arguments

1. **`params`** *(Object)*: Parameters to pass to the API.
1. **`[callback=noop]`** *(Function|null)*: optional callback with signature `callback(error, response)`.

##### Returns

*(Promise)*: Returns a promise that resolves with a result from the API or rejects with an error if it exists.

##### Examples

```JavaScript

vk.accessToken = "your-token"

vk.users.get({fields: "online"}).then(function(result) {})
// Same as vk.method("users.get", ...)

vk.execute({...}, function(error, result) {})
// Same as vk.method("execute", ...)

```
