@login =
  loglink: $ "a[href='#login']"
  unloglink: $ "a[href='#logout']"
  spy: $ ".logged-role"
  text: -> "Logged as " + cookie.get 'user'

  # Unlogged is called every page load
  # if 'logged' and 'token' cookies are not set
  unlogged: ->
    html.addClass('unlogged').removeClass 'logged guest admin'
    cookie.remove 'logged,token,user,role,branch,parent,rate_limit'.split ','
    login.unloglink.removeAttr 'title'
    login.spy.empty()
    login.spy.append $ '<span/>', {text: 'unlogged'}
    return

  # Logged is called every page load,
  # if 'logged' and 'token' cookies are set
  logged: ->
    html.addClass('logged').removeClass('unlogged')
    login.unloglink.attr 'title', login.text()
    login.spy.empty()
    login.spy.append $ '<span/>', {text: login.text()}
    if !cookie.get 'role'
      login.permissions()
    else
      login.update_role cookie.get 'role'
    return

  permissions: ->
    repo = $.get github_repo_url
    repo.done (data) ->
      role = if data.permissions.admin then 'admin' else 'guest'
      notification "Role: #{role}"
      # If it is not a fork then cookie.set abort
      cookie.set('role', role)
        .set 'branch', data.default_branch
        .set 'parent', data.parent?.full_name
      login.update_role role
      return # End permission check
    return

  update_role: (role) ->
    login.unloglink.attr 'title', (i, v) -> "#{v} (#{role})"
    login.spy.find('span').text (i, v) -> "#{v} (#{role})"
    html.addClass(role).removeClass if role is 'admin' then 'guest' else 'admin'
    return
  admin: -> if cookie.get('role') is 'admin' then true else false

login.loglink.on 'click', (e) ->
  token = prompt "Paste a GitHub personal token"
  if !token then return
  cookie.set 'token', token
  auth = $.get '{{ site.github.api_url }}/user'
  auth.done (data) ->
    cookie.set('user', data.login).set 'logged', true
    notification 'Logged', 'green'
    login.logged()
    return # End token check
  auth.fail -> login.unlogged()
  return

login.unloglink.on 'click', ->
  login.unlogged()
  notification 'Logged out'
  return

# Check every page load
if cookie.get('logged') and cookie.get('token') then login.logged() else login.unlogged()