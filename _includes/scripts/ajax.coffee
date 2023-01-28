#
# AJAX PREFILTER
# --------------------------------------
$.ajaxPrefilter (options, ajaxOptions, request) ->

  # Notification on FAIL
  request.fail (request, status, error) ->
    if status isnt 'canceled'
      notification "#{status}: #{request.status} #{request.responseJSON?.message || error}", 'red'
    return # End fail handler

  # Check GitHub requests
  if options.url.startsWith '{{ site.github.api_url }}'
    # Proper Accept header
    options.headers = {'Accept': 'application/vnd.github.v3+json'}
    options.cache = true
    # Add GitHub token
    if cookie.get 'token'
      options.headers['Authorization'] = "token #{cookie.get 'token'}"

  return # End Ajax prefilter

$(document).ajaxStart () -> html.addClass 'ajax'

$(document).ajaxComplete (event, request, ajaxOptions) ->
  html.removeClass 'ajax'
  # Get and cookie-store the `rate_limit` for GitHub
  if ajaxOptions.url.startsWith '{{ site.github.api_url }}'
    if request.getResponseHeader 'x-ratelimit-remaining'
      cookie.set 'rate_limit', +request.getResponseHeader 'x-ratelimit-remaining'

  return # End Ajax complete