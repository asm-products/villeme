class Level < ActiveRecord::Base


	# Associações
	has_many :users



	# Avisa a classe que possui imagem no POST
	has_attached_file :icon

	# Validações
	validates_attachment_presence :icon


	def next
		next_level_nivel = self.nivel + 1
		next_level = Level.find_by nivel: next_level_nivel
		return next_level
	end



end
