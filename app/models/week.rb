class Week < ActiveRecord::Base

	# Associações
	has_and_belongs_to_many :items

	# Globalize translation
	translates :name

end
