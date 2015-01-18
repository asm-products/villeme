
$(document).on 'ready page:load', ->

  $(":file").filestyle
    buttonText: "Escolher foto"
    classButton: "btn btn-default"
    iconName: "icon-plus"
    input: false

  $(".avatar-upload").click ->
    $("#user_avatar").click()
    return

  Gmaps.newMap(gon.latitude, gon.longitude,
    activeSearch: true
    draggable: true
  )

  return