class Persona < ActiveRecord::Base

	# Globalize
	translates :name

	# associações
	has_many :users
	has_many :events

end
