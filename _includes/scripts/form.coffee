#
# Initialize serializeJSON
# --------------------------------------
$.serializeJSON.defaultOptions.skipFalsyValuesForTypes = 'string,number,boolean,date'.split ','

# Enable RANGE OUTPUT
$('input[type=range]').each ->
  $(@).on 'input', (e) -> $(e.target).next('output').val $(e.target).val()
  # Initial update
  $(range).trigger 'input'
  return # end Range loop

# Required asterix
$('input[required]').each -> $(@).before '<sup>*</sup>'

$('form').each ->
  form = $ @

  # Submit
  form.on 'submit', ->
    return # End Form SUBMIT

  # Log button click
  form.on 'click', '[type=button][value=Log]', ->
    form.find(':input').focusout()
    console.log form.serializeJSON()
    return # End Log click event

  # Reset
  form.on 'reset', ->
    form.find(":input").focusout()
    # Reset range output value (next event cycle)
    setTimeout -> form.find('input[type=range]').trigger 'input'
    return # End reset handler

  return # End <form> loops