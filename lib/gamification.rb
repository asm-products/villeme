
GAMIFICATION = false

module Gamification


	# SETTER o level do usuario
	def level_up(user)

		user_points = user.points
		user_level = user.level

		case user_points

		# lvl0 - ovo
		when 0...30
			nivel = 1

		# lvl1 - pintinho
		when 30...42
			nivel = 2

		# lvl2 - Martelo de madeira
		when 42...59
			nivel = 3

		# lvl3 - Martelo duplo de madeira
		when 59...82
			nivel = 4
			
		# lvl4 - Martelo de pedra
		when 82...115
			nivel = 5
			
		# lvl5 - Martelo duplo de pedra
		when 115...161
			nivel = 6

		# lvl6 - Martelo de ferro
		when 161...226
			nivel = 7
		
		# lvl7 - Martelo duplo de ferro 
		when 226...316
			nivel = 8
			
		end

		# get level que o user se encaixa
		to_level = Level.find_by(nivel: nivel)

		# define o level atualizado para o user
		user.level = to_level

		# salva o user
		user.save

	end

end