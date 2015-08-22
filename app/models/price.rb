class Price < ActiveRecord::Base


	# associações
	has_many :items
	has_many :places

end
