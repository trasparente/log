@notification = (code, type = 'default') ->
  console.log $("<b>#{code}</b>").text(), new Date().toLocaleTimeString(lang)
  text = $ "<p class='#{type}-fg'>#{code}</p>"
  $('#notification').prepend text
  # Timer to fade and expire
  text.delay(3000).fadeOut 'slow', -> text.remove()
  return