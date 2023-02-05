#
# Check if HTML build is .behind or .updated
# Check Pulls situation
# Called via body[onload]
# --------------------------------------
@update = ->
  # Abort if development environment
  if '{{ site.github.environment }}' is 'development' then return
  # Abort if rate_limit low
  if +cookie.get 'rate_limit' < 25
    notification "Rate limit too low for updates: #{cookie.get 'rate_limit'}", 'red'
    return
  # Check updated repository
  check_builds()
  # Schedule next check in 1 minute
  setTimeout update, 1000*60
  return # End Update

check_builds = ->
  # Request builds list if admin or commit list if guest
  latest_url = github_repo_url + if login.admin() then '/pages/builds' else '/commits'
  latest_build = $.get latest_url
  latest_build.done (data) ->
    # Get latest build date and SHA
    [latest_date, latest_sha] = if login.admin()
      # Take the first 'built' build
      element = data.filter((build) -> build.status is 'built')[0]
      [element.created_at, element.commit]
    # Get latest commit date and SHA
    else [data[0].commit.author.date, data[0].sha]
    unix = +new Date latest_date
    # Compare latest build created_at or commit date, and site.time
    if unix / 1000 > {{ site.time | date: "%s" }}
      # There was a build or a commit after site.time
      html.addClass('behind').removeClass 'updated'
      loc = window.location
      url_start = loc.origin + loc.pathname
      url_end = latest_date + '&sha=' + latest_sha.slice(0, 7) + loc.hash
      # Refresh on blur
      if html.hasClass 'blur'
        window.location.href = url_start + '?latest=' + url_end
      # Push updated url in hystory
      else history.pushState null, '', url_start + '?update_to=' + url_end
    else
      html.removeClass('behind').addClass 'updated'
      # Build is updated, check sync and pulls for admin users
      if login.admin()
        # If it is a fork check if need sync or pull
        if body.attr('github-fork') is 'true' and cookie.get 'parent'
          # Get upstream commits
          upstream_api = "{{ site.github.api_url }}/repos/#{cookie.get 'parent'}/commits"
          upstream = $.get upstream_api
          upstream.done (data) ->
            # Compare SHAs
            if latest_sha isnt data[0].sha
              # If repository is behind, need sync
              if unix < +new Date(data[0].commit.author.date)
                # Sync with upstream
                # https://docs.github.com/en/rest/branches/branches#sync-a-fork-branch-with-the-upstream-repository
                sync = $.ajax "#{github_repo_url}/merge-upstream",
                  method: 'POST'
                  data: JSON.stringify {"branch": "#{cookie.get 'branch'}"}
                sync.done (data) -> notification 'Synched with upstream branch', 'green'
              # If repository is ahead, need pull
              else open_pull()
            return # End upstream
        # Not a fork, check pulls
        else
          pulls_url = github_repo_url + '/pulls'
          pulls = $.get pulls_url
          pulls.done (data) ->
            if data.length then process_pulls data
            return # End pulls

    return # End latest_build

  return # End updates

{%- capture api -%}
### Update

Updates are checked every minute, only if `rate_limit` is more than 25.

Compare Jekyll `site.time` with GitHub latest built `created_at` (or latest commit `author.date` if user is not admin). If they are different and the browser tab is blurred, refresh the page with a search string like `?latest=YYYY-MM-DDTHH:MM:SSZ&sha=xxxxxxx`.  

If the repository is a fork and logged user is admin, compare branch SHA with upstream and sync if different.
{%- endcapture -%}