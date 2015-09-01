class Subcategory < ActiveRecord::Base

	has_and_belongs_to_many :items

end
