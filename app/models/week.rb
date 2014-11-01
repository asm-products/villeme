class Week < ActiveRecord::Base

	#associações
	has_and_belongs_to_many :events

end
