(($) ->
	App =
		
		###*
		Inicia as funções
		###
		init: ->
			App.BellNotification()
			App.AgendaButton()
			App.FriendActions()
			App.NewsfeedNotification()
			return

		


		###*
		Notificações de amizade
		###
		BellNotification: ->
			$(document).on 'click', '#bell', ->
				$.ajax(
					url: "/notify/bell"
				).done (data) ->
					if data.success
						$("#bell").removeClass("white-font").addClass("green-dark-font")
						$(".bell-wrapper .counter").removeClass("white-font").addClass("green-dark-font")

					return
				return

			return



		###*
		Notificações do newsfeed
		###
		NewsfeedNotification: ->
			$(document).on 'click', '#newsfeed-link', ->
				$.ajax(
					url: "/notify/newsfeed"
				).done (data) ->
					if data.success
						$("#newsfeed-link").find(".badge").html("")

					return
				return

			return



		
		###*
		Ativa o botão para agendar eventos
		###
		AgendaButton: ->
			$(document).on 'click', '.agenda-btn', ->

				$.ajax(
					url: $(this).attr("data-schedule-url")
				).done (data) ->
					
					event = $("#"+data.event)
					agended = data.agended
					agenda_new_count = data.count
					agended_by_new_count = data.agended_by_count
					new_title = data.new_title

					if agended
						event.find(".agenda-btn").addClass("green-bg schedule").removeClass("white-bg unschedule")
						event.find(".agenda-btn .text").text("Agendado")
						event.find(".day").addClass("agended")
					else
						event.find(".agenda-btn").addClass("white-bg unschedule").removeClass("green-bg schedule")
						event.find(".agenda-btn .text").text("Agendar")
						event.find(".day").removeClass("agended")

					$("#agenda-count").text("").text(agenda_new_count)
					event.find(".agended-by-count").text("").text(agended_by_new_count)
					event.find(".agended-by-count").attr("data-original-title", new_title)

					return
				return
			return





		###
		Controla a requisição, aceitação e destruição de amizades 
		###
		FriendActions: ->
			# Requisição de amizade
			$(document).on 'click', '.friend-request', ->
				$.ajax(
					url: "/friendships/request"
					data: 
						friend: $(this).attr("data-friend-object")			
				).done (data) ->
					if data.success
						friend = $("#friend-"+data.friend_id)
						btn = $("#friend-btn-"+data.friend_id)
						friend.attr "data-content", "<button class='btn btn-success'>Amizade solicitada</button>"
						btn.text("Amizade solicitada").toggleClass("btn-default btn-success")

					return
				return

			# Aceitar amizade
			$(document).on 'click', '.friend-accept', ->
				$.ajax(
					url: "/friendships/accept"
					data: 
						friend: $(this).attr("data-friend-object")			
				).done (data) ->
					if data.success
						friend = $("#friend-"+data.friend_id)
						friend.attr "data-content", "<button class='btn btn-success'>Amizade aceita</button>"

					return
				return

			# Desfazer amizade
			$(document).on 'click', '.friend-destroy', ->
				$.ajax(
					url: "/friendships/destroy"
					data: 
						friend: $(this).attr("data-friend-object")			
				).done (data) ->
					if data.success
						friend = $("#friend-"+data.friend_id)
						friend.attr "data-content", "<button class='btn btn-success'>Amizade desfeita</button>"

					return
				return
				
			return



	$ ->
		App.init()
		return



	return
) jQuery