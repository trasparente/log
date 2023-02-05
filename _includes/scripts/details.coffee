$('details').each ->

  # Prepare
  detail = $ @
  states = cookie.get('states') || []
  summary = detail.find 'summary'
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