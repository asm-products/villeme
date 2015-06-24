class Persona < ActiveRecord::Base

	# Globalize
	translates :name

	# associações
	has_and_belongs_to_many :users
	has_and_belongs_to_many :events
	has_and_belongs_to_many :invites

end
