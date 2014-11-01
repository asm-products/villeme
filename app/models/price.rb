class Price < ActiveRecord::Base


	# associações
	has_many :events
	has_many :places

end
