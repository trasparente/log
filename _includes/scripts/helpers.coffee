#
# VAR
# --------------------------------------
win = $(window)
dom = $(document)
html = $ 'html'
body = $ 'body'
root_path = new URL("{{ '' | absolute_url }}").pathname
github_repo_url = '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}'
lang = '{{ page.language | default: site.language | default: 'en' }}'

# Return ISO 8601 date "YYYY-MM-DD"
date_iso = (date) -> new Date(date || +new Date()).toLocaleDateString 'en-CA'

# Check if string is parsable
@parsable = (string) ->
  try
    JSON.parse(string)
  catch e
    return false
  return true

#
# PREVENT-DEFAULT CLASS
# --------------------------------------
dom.on 'click', 'a.prevent', (e) -> e.preventDefault()
dom.on 'submit', 'form.prevent', (e) -> e.preventDefault()

#
# Duplicate `[cite]` in empty `[title]`
# --------------------------------------
$('[cite]:not([title])').each -> $(@).attr 'title', $(@).attr 'cite'

#
# Duplicate `[href]` in empty `[title]`
# --------------------------------------
$('[href]:not([title])').each -> $(@).attr 'title', $(@).attr 'href'

#
# TABLES on MOBILE
# --------------------------------------
# $('main table').each ->
#   table = $ @
#   table
#     .after($('<div style="overflow-x:auto;margin-block:1em"></div>')
#     .append(table.clone().css('margin',0)))
#   table.remove()
#   return

#
# Search function for INPUT.search-input
# on `keydown`, filter [search-string] elements
# hiding those not containing the input value
# --------------------------------------
dom.on 'keyup', 'input', (e) ->
  input = $ e.target

  # Every INPUT get blurred on ENTER
  # get blurred and null valued on ESC
  switch e.keyCode
    when 13 then input.blur()
    when 27
      input.val ''
      input.blur()

  if input.hasClass 'search-input' then search input

  return

#
# SEARCH FILTER function
# .search-input, [search-string]
# --------------------------------------
search = (e) ->
  input = $ e
  value = input.val()
  # Search value among `parent > siblings [search-string]`
  # Loop siblings
  $(input.parent()).siblings().each ->
    # Loop elements with search-strings
    $(@).find('[search-string]').each ->
      element = $ @
      # Hide or Show if contains input value
      if element.attr('search-string').indexOf(value) is -1
        element.addClass 'hidden'
      else element.removeClass 'hidden'
      return # End search-strings loop
    return # End siblings loop

  return # End search filter function

if location.search
  # Serialize search string to object
  search = new URLSearchParams location.search
  obj = Object.fromEntries search.entries()
  # Loop filters object
  for k, v of obj
    # Loop target elements
    $("[search-#{k}]").each ->
      element = $ @
      attr = element.attr "search-#{k}"
      if !attr or !attr.includes v then element.addClass 'display--none'
      return
    # Add `.active` to filter links
    $("[rel*='search'][href*='#{k}'][href*='#{v}']").each ->
      $(@).addClass('active').attr 'href', location.origin + location.pathname
      return
  # Update `.only-visible-child`
  $('.only-visible-child').each ->
    parent = $(@).parent().children().filter -> $(@).is(':visible')
    if !parent.length then $(@).show()
    return

#
# SCROLL Event
# Add `html.scrolled` when scroll > win height
# --------------------------------------
win.scroll () ->
  if win.scrollTop() > win.height()
    html.addClass 'scrolled'
  else html.removeClass 'scrolled'
  return

#
# FOCUS / BLUR
# Called from BODY attribute
# --------------------------------------

@focus = -> html.addClass('focus').removeClass 'blur'
@blur = -> html.addClass('blur').removeClass 'focus'
if document.hasFocus() then focus() else blur()

#
# ONLINE / OFFLINE
# Called from BODY attribute
# --------------------------------------

@online = -> html.addClass('online').removeClass 'offline'
@offline = -> html.addClass('offline').removeClass 'online'
if navigator.onLine then online() else offline()

#
# FULLSCREEN: WINDOW RESIZE EVENT
# Add class `fullscreen`
# Called from BODY attribute
# --------------------------------------

@resize = ->
  if !window.screenTop and !window.screenY
    html.addClass 'fullscreen'
  else 
    html.removeClass 'fullscreen'
  return

resize()

#
# SLUG / UNSLUG
# --------------------------------------

@slug = (string) -> 
  return string.toString().toLowerCase().trim()
    .replace /[^\w\s\.—-]/g, '' # Remove every: not word, space, dot, dashes
    .replace /[\s\.—-]+/g, '_' # Replaces space, dot, dashes with underscore
    .replace /^_+|_+$/g, '' # Trim underscore

@unslug = (string) ->
  out = string.replace /[_]/g, ' '
  return out.charAt(0).toUpperCase() + out.slice 1