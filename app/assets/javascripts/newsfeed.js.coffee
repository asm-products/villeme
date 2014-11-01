(($) ->

	# array que guardará todos os timeouts
	timeouts = []



	Newsfeed =


		###
		Inicia as funções
		###
		init: ->
			Newsfeed.EventEvents()
			Newsfeed.UserEvent()
			return




		
		###
		Eventos que ocorrem com a interação nos eventos em grid
		###
		EventEvents: ->

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

				$("#neighborhood-count").hide()

				# mostra as infos
				$("#sidebar-map .infos").filter(":not(:animated)").fadeIn 200
					
				# mostra o nome do evento no mapa
				$(".address").fadeIn("fast").text($(this).attr("address"))

				# mostra o a distância de ônibus
				$(".walk .data").fadeIn("fast").text($(this).attr("walk"))

				# mostra o a distância de ônibus
				$(".bike .data").fadeIn("fast").text($(this).attr("bike"))

				# mostra o a distância de ônibus
				$(".bus .data").fadeIn("fast").text($(this).attr("bus"))

				# mostra o a distância de ônibus
				$(".car .data").fadeIn("fast").text($(this).attr("car"))								

				latLng = new google.maps.LatLng($(this).attr("latitude"), $(this).attr("longitude"))
				marker = $("#user-map").gmap3(get:
					id: $(this).attr "letter"
				)

				map = $("#user-map").gmap3("get")
				map.panTo latLng

				marker.setZIndex(10)
				# marker.setIcon("images/marker-red-a.png")

				return








			# event mouseleave
			$(".event .panel").mouseleave ->
				$(".infobox").hide().text("")
			

				# esconde a legenda
				$(this).find(".letter").fadeOut("fast")

				latLng = new google.maps.LatLng(gon.latitude, gon.longitude)
				marker = $("#user-map").gmap3(get:
					id: $(this).attr "letter"
				)

				map = $("#user-map").gmap3("get")

				mostraNeighborhoodCount = ->
					$("#neighborhood-count").show()
					return

				# delay para ajustar o centro do mapa
				pan = ->
					map.panTo(latLng)
					return

				escondeInfos = ->
					$("#sidebar-map .infos").hide()	
					return

				timeouts.push(setTimeout(pan, 6500))
				timeouts.push(setTimeout(escondeInfos, 450))
				timeouts.push(setTimeout(mostraNeighborhoodCount, 460))
			
				marker.setZIndex(1)
			
				return

			return



		###
		Eventos que ocorrem com a interação com o mapa
		###
		UserEvent: ->
			# map mouseenter
			$("#user-map").mouseenter ->
				# limpa o timeout
				i = 0
				while i < timeouts.length
					clearTimeout timeouts[i]
					i++

				timeouts = []
				# ---
				return

			return




	$ ->
		Newsfeed.init()
		return

	return
			
) jQuery











