ready = ->
  console.log Math.floor(Math.random()*11)
  $('textarea:not(.no-editor)').each (i, elem)->
    $(elem).wysihtml5 locale: 'fr-FR'

  $(".wysihtml5-sandbox").css 'resize', 'vertical'


document.addEventListener 'page:restore', ->
  if $('textarea:not(.no-editor)').length
    location.reload()

$(document).ready(ready)
$(document).on('page:load', ready)