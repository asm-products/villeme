(($) ->

  # array que guardará todos os timeouts
  timeouts = []



  Newsfeed =


    ###
    Inicia as funções
    ###
    init: ->
      Newsfeed.eventEvents()
      Newsfeed.userEvent()
      Newsfeed.createMap()
      Newsfeed.fixingMapOnScroll()
      return



    createMap: ->
      newMap = ->
        new Gmaps(gon.latitude, gon.longitude)
        return

      setTimeout(newMap, 650)
      return



    eventEvents: ->

      # event mouseenter
      $(".event .panel").mouseenter ->
        # limpa o timeout
        i = 0
        while i < timeouts.length
          clearTimeout timeouts[i]
          i++

        timeouts = []

        # mostra a legenda
        $(this).find(".letter").fadeIn("fast")

        # pega a letra
        letra = $(this).find(".letter").text()

        $(".SidebarMap-neighborhoodCount").hide()

        # mostra as infos
        $(".SidebarMap-infos").filter(":not(:animated)").fadeIn 200

        # mostra o nome do evento no mapa
        $(".address").fadeIn("fast").text($(this).attr("address"))

        # mostra o a distância de ônibus
        $(".js-distanceWithWalking .data").fadeIn("fast").text($(this).attr("walk"))

        # mostra o a distância de ônibus
        $(".js-distanceWithBike .data").fadeIn("fast").text($(this).attr("bike"))

        # mostra o a distância de ônibus
        $(".js-distanceWithBus .data").fadeIn("fast").text($(this).attr("bus"))

        # mostra o a distância de ônibus
        $(".js-distanceWithCar .data").fadeIn("fast").text($(this).attr("car"))

        # TODO: Use Gmap module to construct this map
        Gmaps.panTo($(this).attr("latitude"), $(this).attr("longitude"))

        return


      # event mouseleave
      $(".event .panel").mouseleave ->
        $(".infobox").hide().text("")


        # esconde a legenda
        $(this).find(".letter").fadeOut("fast")

        latLng = new google.maps.LatLng(gon.latitude, gon.longitude)
        marker = $("#map").gmap3(get:
          id: $(this).attr "letter"
        )

        map = $("#map").gmap3("get")

        mostraNeighborhoodCount = ->
          $(".SidebarMap-neighborhoodCount").show()
          return

        # delay para ajustar o centro do mapa
        pan = ->
          map.panTo(latLng)
          return

        escondeInfos = ->
          $(".Side").hide()
          return

        timeouts.push(setTimeout(pan, 6500))
        timeouts.push(setTimeout(escondeInfos, 450))
        timeouts.push(setTimeout(mostraNeighborhoodCount, 460))


        return

      return





    userEvent: ->
      # map mouseenter
      $("#map").mouseenter ->
        # limpa o timeout
        i = 0
        while i < timeouts.length
          clearTimeout timeouts[i]
          i++

        timeouts = []
        # ---
        return

      return


    fixingMapOnScroll: ->
      position = 0

      $(window).scroll ->
        scroll = $(window).scrollTop()
        if scroll > position
          $('.js-FixingMapOnScroll').css({top: scroll})
        else
          $('.js-FixingMapOnScroll').css({top: scroll})

        position = scroll
        return

      return


  $ ->
    Newsfeed.init()
    return

  return

) jQuery











