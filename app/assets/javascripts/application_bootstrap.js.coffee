(($) ->

	BootstrapJS = 


		init: ->
			BootstrapJS.Tooltip()
			BootstrapJS.Dropdown()
			BootstrapJS.Modal()
			BootstrapJS.ModalFeedback()
			BootstrapJS.Affix()
			BootstrapJS.Popover()
			return


		Tooltip: ->
			# Tooltip
			$(document).on "mouseenter", ".has-tooltip", ->
				$(this).tooltip(
					container: "body"
					delay:
						show: 600
						hide: 150
				).tooltip "show"
				return
			return

	
		Dropdown: ->
			$("a[rel~=dropdown], .has-dropdown").dropdown()
			return


		Modal: ->
			$(".has-modal").click ->
				$("#modal").modal "toggle"
				return
			return


		ModalFeedback: ->
			$(".has-modal-feedback").click ->
				$("#modal-feedback").modal "toggle"
				return		
			return


		Affix: ->
			$(".col-fixed").affix()
			return


		Popover: ->
			# Popover

			$(document).on("mouseenter", ".has-popover", ->
				$(this).popover
					trigger: "manual"
					html: true
				
				_this = this
				$(this).popover "show"

				$(".popover").on "mouseleave", ->
					$(_this).popover "hide"
					return
				$(".popover").on "click", ->
					$(_this).popover "hide"
					return	    

				return
			).on "mouseleave", ".has-popover", ->
				_this = this
				setTimeout (->
					$(_this).popover "hide"  unless $(".popover:hover").length
					return
				), 100
				return



			# Popover - click

			$(".has-popover-click").popover(
				html: true
				trigger: "manual"
			).click (e) ->
				$(".has-popover-click").not(this).popover "hide"
				$(this).popover "toggle"
				return

			$(document).click (e) ->
				$(".has-popover-click").popover "hide"  unless $(e.target).is(".has-popover-click, .popover-title, .popover-content, .popover")
				return
			return


	$ ->
		BootstrapJS.init()
		return

	return

) jQuery