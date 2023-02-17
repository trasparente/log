# Open details on hover for NAV
$('nav .wrapper > details, nav .wrapper > a').each ->
  item = $(@)
  item.hover ->
    # close sibilings
    item.siblings('details').each -> $(@)[0].open = false
    if item.prop('tagName') is 'DETAILS' then item[0].open = true
    return
  return

# Close navigation details when on main
$('main').hover -> $('nav .wrapper > details').each ->
  $(@)[0].open = false
  return

# Save and Load states from cookie
$('details').each ->

  # Prepare
  detail = $ @
  states = cookie.get('states') || []
  summary = detail.find 'summary'
  # filter page-agnostic details
  title = if detail.parents('aside.sidebar').length then 'details' else body.attr 'page-title'
  id = "#{title}|#{$.trim summary.text()}"

  # Initial check on Details cookie array
  if id in states
    # If found then flip it
    if detail.attr 'open' then detail.removeAttr 'open' else detail.attr 'open', ''
  
  # Click event
  summary.on 'click', ->
    if id in states
      # Remove element
      states.splice $.inArray(id, states), 1
    else
      # Add element
      states.push id
    # Save new states array
    cookie.set 'states', states
    return

  return # End DETAILS loop

{%- capture api -%}
### Details

<details markdown=1>
<summary>Open</summary>
Cookie-save and reinstate the state of the `<details>`{:.language-html} elements (open/close) in every page. Sidebar details are page-agnostic.
</details>

{%- endcapture -%}