class Week < ActiveRecord::Base

	# Associações
	has_and_belongs_to_many :events

	# Globalize translation
	translates :name

end
