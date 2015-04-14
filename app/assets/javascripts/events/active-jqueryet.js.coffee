$(document).ready ->

  $("#event_description").jqte
    focus: ->
      $(".jqte_editor").height(450)
      return
    blur: ->
      $(".jqte_editor").height(100)
      return

  return