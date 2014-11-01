class City < ActiveRecord::Base


	# asssociações
	has_many :neighborhoods, dependent: :destroy
	has_many :events, through: :neighborhoods
	has_many :users

end
