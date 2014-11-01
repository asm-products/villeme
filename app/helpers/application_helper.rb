# encoding: utf-8

module ApplicationHelper

	@gamification_active = false

	def javascript(*files)
	  content_for(:javascript) { javascript_include_tag(*files, 'data-turbolinks-track' => true) }
	end

	def css(*files)
	  content_for(:css) { stylesheet_link_tag(*files) }
	end	



	# cria uma username com o nome do usuario
	def create_username


		if current_user.username.blank?

			require 'i18n'

			# pega o nome do usuario
			name = I18n.transliterate(current_user.name)
			username = name.split.first.downcase

			unless username_exist(username)
				return username
			else

				username = name.split[0..1].join.downcase

				if name.split.count > 1
					unless username_exist(username)
						return username
					else
						return name.split[0..2].join.downcase
					end

				else

					return name.split[0..1].join.downcase + rand(10).to_s

				end
			end

		else

			return current_user.username

		end


	end

	def username_exist(username)
		if User.where(username: username).first
			true
		else
			false
		end
	end






	def get_avatar(user, w = "38", h = "38")

		size = "#{w}x#{h}"

		if user.is_a? Numeric
			user = User.find user
		end

		if user_signed_in?
			if user.avatar_file_name != nil
				return x_image_tag user.avatar.url(:thumb), class: "avatar-upload img-circle image", size: size, alt: user.name
			elsif user.facebook_avatar
				return x_image_tag "#{user.facebook_avatar}?width=#{w}&height=#{h}", class: "avatar-upload img-circle image", size: size, alt: user.name
			else
				return x_image_tag "thumb/missing.png", class: "avatar-upload img-circle image", size: size
			end
		else
			return x_image_tag "thumb/missing.png", class: "avatar-upload img-circle image", size: size
		end
	end









	# Botao para ações de amizade
	# -> Adicionar e destruir amizade 

	DEFAULT = {status: "auto", hash: false, css: nil}

	def btn_friend(user, friend, options = {})
		
		options = DEFAULT.merge(options)

		# Blocos de 'status'

		confirmed = proc do
			if hash
				btn = "<button id='friend-btn-#{friend[:id]}' class='btn btn-default friend-destroy has-hover-action #{options[:css]}' data-text-default='Amigo' data-text-hover='Desfazer amizade' data-class-hover='btn-danger btn-default' data-friend-object='#{friend[:slug]}'>Amigo</button>".html_safe		
			else	
				btn = "<button id='friend-btn-#{friend.id}' class='btn btn-default friend-destroy has-hover-action #{options[:css]}' data-text-default='Amigo' data-text-hover='Desfazer amizade' data-class-hover='btn-danger btn-default' data-friend-object='#{friend.slug}'>Amigo</button>".html_safe
			end
		end
		

		requested = proc do
			if hash
				btn = "<button id='friend-btn-#{friend[:id]}' class='btn btn-default friend-destroy #{options[:css]}' data-friend-object='#{friend[:slug]}'>Amizade solicitada</button>".html_safe			
			else	
				btn = "<button id='friend-btn-#{friend.id}' class='btn btn-default friend-destroy #{options[:css]}' data-friend-object='#{friend.slug}'>Amizade solicitada</button>".html_safe
			end
		end


		pending = proc do
			if options[:hash]
				btn = "<button id='friend-btn-#{friend[:id]}' class='btn btn-success friend-accept #{options[:css]}' data-friend-object='#{friend[:slug]}'>Aceitar amizade</button>".html_safe		
			else	
				btn = "<button id='friend-btn-#{friend.id}' class='btn btn-success friend-accept #{options[:css]}' data-friend-object='#{friend.slug}'>Aceitar amizade</button>".html_safe
			end
		end


		not_friend = proc do
			if options[:hash]
				btn = "<button id='friend-btn-#{friend[:id]}' class='btn btn-success friend-request #{options[:css]}' data-friend-object='#{friend[:slug]}'>Solicitar amizade</button>".html_safe			
			else	
				btn = "<button id='friend-btn-#{friend.id}' class='btn btn-success friend-request #{options[:css]}' data-friend-object='#{friend.slug}'>Solicitar amizade</button>".html_safe
			end
		end	

		
		# Algoritimo

		case options[:status]
		when "confirmed"
			confirmed.call
		
		when "requested"
			requested.call

		when "pending"
			pending.call

		when "not-friend"
			not_friend.call

		when "auto"
			if current_user.are_friends? friend
				confirmed.call
			else
				not_friend.call							
			end
		end	


		


	end






end
