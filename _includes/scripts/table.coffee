# Inject search box in TABLES
$('table').each ->
  table = $ @

  # Add `search-string` attribute to TR
  # with all the TD strings
  table.find('tbody tr').each ->
    row = $ @
    string = []
    row.find('td').each -> string.push $(@).text()
    row.attr 'search-string', string.join ' '
    return

  # Add Search widget
  container = $ '<div/>', {class: 'search-container'}
  table.prepend container.append $ '<input/>',
    type: 'search'
    placeholder: 'Search'
    class: 'search-input'

  return # End tables loop

{%- capture api -%}
## Tables

Every `table:not(.no-search)`{:.language-css} has a searchbox injected.

```html
<table>
  <div class="search-container">
    <input type="search" placeholder="Search" class="search-input">
  </div>
  <!-- ... -->
</table>
```

**Example**

| Header1 | Header2 | Header3 |
|:---|:---:|---:|
| odd body | cell2 | cell3 |
| cell4 | cell5 | cell6 |
|----
| even body | cell2 | cell3 |
| cell4 | cell5 | cell6 |
|----
| cell1 | cell2 | cell3 |
|====
| Foot1 | Foot2 | Foot3
{%- endcapture -%}