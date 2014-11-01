class Persona < ActiveRecord::Base

	# associações
	has_many :users
	has_many :events

end
