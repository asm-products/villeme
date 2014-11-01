
# EVENT.NEW.EDIT

$(document).on 'ready page:done', ->

	$(".criar-lugar, .hour-hide").hide()

	# Objetos não obrigatorios
	$(".not-required").mouseenter ->
		$(this).removeClass("not-required")
		return	


	$(".event-img").parents(".form-group").mouseover -> 
		fileName = $("#event_image").val()

		if fileName
			$(".event-text").text("Imagem enviada!")
			$(".event-img").addClass("green-font green-border")
		else 
			$(".event-text").text("Sem imagem")
			$(".event-img").removeClass("green-font green-border")

		return

	$(".remove-img").click ->
		$(".event-img").css("background-image":"none")
		$(":file").filestyle('clear')
		$(".event-text").text("Enviar imagem")
		$(".event-img").removeClass("green-font green-border")		
		return

	$(".tab-lugar").click ->
		$(".address-inputs").hide()
		$(".place-form").show()
		$(".tab-endereco").removeClass "tab-selected"
		$(this).addClass "tab-selected"

		latLng = new google.maps.LatLng(gon.latitude, gon.longitude)

		# Ajusta o tamanho do mapa - hide to show bug
		map = $("#place-map").gmap3("get")
		google.maps.event.trigger(map, "resize") 
		map.panTo latLng


		return


	$(".tab-endereco").click ->
		$(".address-inputs").show()
		$(".place-form, .criar-lugar").hide()
		$(".tab-lugar").removeClass "tab-selected"
		$(this).addClass "tab-selected"

		latLng = new google.maps.LatLng(gon.latitude, gon.longitude)

		# Ajusta o tamanho do mapa - hide to show bug
		map = $("#map").gmap3("get")
		google.maps.event.trigger(map, "resize") 
		map.panTo latLng

		return

	$("#event_place_attributes_address, #event_address").focusout ->
		$("#place-endereco").val($(this).val())
		return

	$("#place-number, #number").focusout ->
		$("#place-endereco").val($("#event_place_attributes_address").val() + " " + $(this).val())
		return

	$("#neighborhood-place, #neighborhood").focusout ->
		$("#place-endereco").val($("#event_place_attributes_address").val() + " " + $("#place-number").val() + " " + $(this).val())
		return




	$(":file").filestyle
		buttonText: "Enviar imagem..."
		classButton: "btn btn-default"
		input: false

	$(".image-upload").click ->
		$("#event_image").click()
		return

	$(".has-helper").mouseenter ->
		helper = $(this).attr("helper")
		$(".helper-text").html("")
		$("#helper").fadeIn()
		$(".helper-text").html(helper)
		return

	$(".panel").mouseleave ->
		$("#helper").fadeOut()
		return

	# ativa o wysing para o campo descrição
	$("#event_description").wysihtml5
		"color": false
		"image": false
		"font-styles": false
		"link": false


		# ativa o wysing para o campo 'cost details'
	$("#event_cost_details").wysihtml5
		"color": false
		"image": false
		"font-styles": false
		"link": false
		"emphasis": false		
		"lists": false






	# botões add maior horarios
	$(".glyphicon-plus").click ->
		$(this).parents(".hour-block").next(".hour-block").fadeIn()
		return

	#mascara de dinheiro
	$('#event_cost_fake, #event_cost').maskMoney 
		prefix: "R$ "
		allowNegative: false
		thousands: "."
		decimal: ","
		affixesStay: false

	$("#event_cost_fake").focusout ->
		dinheiro = $("#event_cost_fake").val()
		dinheiroConvertido = dinheiro.replace(",", "").replace(".", "").replace("R$","")
		$("#event_cost").val(dinheiroConvertido)
		return

	# #mascara de dinheiro
	# $('#event_cost').mask "#.##0,00",
	#   reverse: true
	#   maxlength: false		




	$(".not-required-show").click ->
		$(this).hide()
		$(".not-required-block").show()
		return





	# SHOW -------------------------------------------

	url = $(location).attr('href')

	# Descrição completa
	$(".read-more, .snippet").click ->
		$.ajax(
			url:  url + "/fulldescription"
		).done (data) ->

			$(".read-more").hide()
			
			description = data.full_description
			$(".description").removeClass("snippet").html(description)
			return
		return


	# Nova dica
	$("#new-tip").on 'ajax:success', (event, data, status, xhr) ->
		if data.valid
			$(".tips").prepend("<li class='list-group-item'><b>" + data.user + "</b> - " + data.description + " — <span class='grey-font-50'>Há " + data.created_at + "</span></li>")
		else
			$(".tips").prepend("<li class='list-group-item'><b>Você so pode enviar 2 dicas por evento.</b></li>")

		return		

	$("#tip_description").keyup ->
	  max = 140
	  len = $(this).val().length
	  if len >= max
	    $(".tip-counter b").text "Sua dica precisa ter menos de 140 caracteres."
	  else
	    char = max - len
	    $(".tip-counter b").text char + " caracteres."
	  return
		
	



	return

# -----------------------------------------------------