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
      Newsfeed.sidebarLeftLinksAnimation()
      return



    createMap: ->
      $(document).on 'ready page:done', ->
        if $('#main').is(':visible')
          setTimeout(->
            new Gmaps(gon.latitude, gon.longitude)

            map = $('#map').gmap3("get")
            google.maps.event.trigger(map, "resize");
            Gmaps.centerTo(gon.latitude, gon.longitude)
          , 350)
        else
          $(document).on 'page:done', ->
            setTimeout(->
              Gmaps.clearMarker()
              new Gmaps(gon.latitude, gon.longitude)

              map = $('#map').gmap3("get")
              google.maps.event.trigger(map, "resize")
              Gmaps.centerTo(gon.latitude, gon.longitude)
            , 350)
            return
        return

      return



    eventEvents: ->

      # event mouseenter
      $(".Event--newsFeed .panel").mouseenter ->
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
        $(".SidebarMap-address").fadeIn("fast")
        placeAndAddres = undefined
        if $(this).attr("data-place") isnt ""
          placeAndAddres = ("<b>" + $(this).attr("data-place") + "</b><br/>" + " " + $(this).attr("data-address"))
        else
          placeAndAddres = $(this).attr("data-address")
        $(".SidebarMap-address span").html(placeAndAddres)

        # mostra o a distância de ônibus
        $(".js-distanceWithWalking .data").fadeIn("fast").text($(this).attr("data-walk"))

        # mostra o a distância de ônibus
        $(".js-distanceWithBike .data").fadeIn("fast").text($(this).attr("data-bike"))

        # mostra o a distância de ônibus
        $(".js-distanceWithBus .data").fadeIn("fast").text($(this).attr("data-bus"))

        # mostra o a distância de ônibus
        $(".js-distanceWithCar .data").fadeIn("fast").text($(this).attr("data-car"))

        # TODO: Use Gmap module to construct this map
        map = $('#map').gmap3("get")
        google.maps.event.trigger(map, "resize");
        Gmaps.panTo($(this).attr("data-latitude"), $(this).attr("data-longitude"))

        return


      # event mouseleave
      $(".Event--newsFeed .panel").mouseleave ->
        $(".infobox").hide().text("")


        # esconde a legenda
        $(this).find(".letter").fadeOut("fast")

        latLng = new google.maps.LatLng(gon.latitude, gon.longitude)
        marker = $("#map").gmap3(get:
          id: $(this).attr "data-letter"
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
          $(".SidebarMap-infos, .SidebarMap-address").hide()
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



    sidebarLeftLinksAnimation: ->
      $('.SidebarLeft-nav a').on 'click', ->
        scrollAnchor = $(this).attr('data-scroll')
        scrollPoint = $('section[data-anchor="' + scrollAnchor + '"]').offset().top - 85
        $('body,html').animate { scrollTop: scrollPoint }, 500
        false
      $(window).scroll(->
        windscroll = $(window).scrollTop()
        if windscroll >= 100
          $('.Main section').each (i) ->
            if $(this).position().top <= windscroll + 25
              $('.SidebarLeft-nav a.is-active').removeClass 'is-active'
              $('.SidebarLeft-nav a').eq(i).addClass 'is-active'
            return
        else
          $('.SidebarLeft-nav a.is-active').removeClass 'is-active'
          $('.SidebarLeft-nav a:first').addClass 'is-active'
        return
      ).scroll()

      return


  $ ->
    Newsfeed.init()
    return

  return

) jQuery











