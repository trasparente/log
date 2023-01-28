#
# COOKIE wrapper
# --------------------------------------
@cookie =
  string: -> document.cookie
  array: -> cookie.string().split(';').map (c) -> c.trim()

  get: (key = 0) ->
    if !key then return cookie.string()
    found = cookie.array().filter (c) -> c.split("=")[0] is key
    value = switch found.length
      when 0 then undefined
      else found[0].split('=')[1]
    return if parsable value then JSON.parse value else value

  set: (key = '', value = '', options = {}) ->
    string = if typeof value is 'string' then value else JSON.stringify value
    # Remove cookie if empty array/object
    # Empty string could also be `parent=`
    if string in ['[]', '{}'] then return cookie.remove key
    data = "#{key}=#{string}; samesite=strict;"
    expires = switch
      when options.expires is false then 'expires=Fri, 31 Dec 9999 23:59:59 GMT;'
      when Date.parse options.expires then "expires=#{options.expires};"
      when typeof options.expires is 'number' then "max-age=#{options.expires};"
      else ''
    # Default path is not current page but `root_path`
    document.cookie = "#{data} path=#{if options.path then options.path else root_path}; #{expires}"
    return cookie

  remove: (key = '', path = '') ->
    path_string = "path=#{if path then path else root_path}; "
    if !Array.isArray key then key = [key]
    for k in key
      document.cookie = "#{k}=; #{path_string}samesite=strict; max-age=0;"
    return cookie

{%- capture api -%}
## Cookies

Cookies wrapper

```coffee
# SET: cookie.set(key, value, option) return cookie for chaining
#   key {string} cookie name
#   value {string/object/array} cookie value, [] and {} will remove the cookie
#   options {object}
#     expires {undefined/date/number/false} expiration: session/date/max-age(sec)/never
#     path {string} default to root_path
#
# GET: cookie.get(key) return cookie value (string/array/object), or document.cookie if no key
#   key {string} cookie name
#
# REMOVE: cookie.remove(key [, path]) return cookie object for chaining
#   key {string/array} cookie name or array of names
#   path {string} cookie path to remove
```

> Warning: Many web browsers have a session restore feature that will save all tabs and restore them the next time the browser is used. Session cookies will also be restored, as if the browser was never closed.
{%- endcapture -%}