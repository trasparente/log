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

  # Reset
  form.on 'reset', ->
    form.find(":input").focusout()

    # Reset range output value
    # Default delay is 0ms, 'immediately' i.e. next event cycle
    # actual delay may be longer
    setTimeout -> form.find('input[type=range]').trigger 'input'

    return # End reset handler

  return # End <form> loops