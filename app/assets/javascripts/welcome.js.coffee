# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

	# mostra input de sugestão para cidade
	$(".invite_city .hint a").click ->
		$("#city-sugest").fadeIn()
		return

	# mostra input de sugestão para persona
	$(".invite_persona .hint a").click ->
		$("#persona_sugest").fadeIn()
		return


	$(".temporary-slogan").hide()
	$(".slogan").show()


	$(".wodry").wodry
		animation: 'rotateX'
		delay: 10000
		animationDuration: 400



	# rola ate os beneficios
	$("a[href^=\"#\"]").on "click", (e) ->
		e.preventDefault()
		target = @hash
		$target = $(target)
		$("html, body").stop().animate
			scrollTop: $target.offset().top
		, 900, ->
			window.location.hash = target
			return

		return

	# esconde head ao rolar tela
	h = window.innerHeight
	if h < 750
		$("#header-hide-on-scroll, #header-hide-on-scroll-dark").height h
		$("#header-hide-on-scroll-dark").css "margin-top", -h
	else
		$("#header-hide-on-scroll, #header-hide-on-scroll-dark").height 750
		$("#header-hide-on-scroll-dark").css "margin-top", -750

	$(window).on "scroll", ->
		st = $(this).scrollTop()
		$("#header-hide-on-scroll").css "opacity", (1 - st / h)
		$("#header-hide-on-scroll").css "background-position", "0px " + (0 - (st / 2)).toString() + "px"
		$(".plataforms").css "top", (h / 9) + (st / 4)


		return


	#troca a fotografia de fundo
	setTimeout( ->
		$("#header-hide-on-scroll").animate
			opacity: 1
		, 1200

		$(".plataforms").animate
			top: (h / 9)
		, 800

		$("#header-hide-on-scroll-dark").animate
			opacity: 0
		, 1200

	, 2500
	)


	# Gmail em breve
	$(".gmail").mouseover ->
		$(this).find(".text").text("disponível em breve")
		return

	$(".gmail").mouseleave ->
		$(this).find(".text").text("entrar com gmail")
		return


	$(".goals .has-modal").click ->
		city = $(this).attr('data-city')
		$(".has-selectpicker").selectpicker("val", city)
		return

	$("#address").focusin ->
		Gmaps.newMap(-22.951916, -43.210487)
		return

	# Bootstrap Select
	$(".has-selectpicker").selectpicker()





	# Facebook SKD Client popout login
	$('body').prepend('<div id="fb-root"></div>')

	$.ajax
		url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
		dataType: 'script'
		cache: true

	window.fbAsyncInit = ->
		FB.init(appId: '568047899941238', cookie: true)

		$('#sign_in').click (e) ->
			e.preventDefault()
			FB.login (response) ->
				window.location = 'users/auth/facebook' if response.authResponse
				return
			return

		$('#sign_out').click (e) ->
			FB.getLoginStatus (response) ->
				FB.logout() if response.authResponse
				return
			true
			return

		return

	return