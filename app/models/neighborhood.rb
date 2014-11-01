class Neighborhood < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged	

	# associações
	has_many :places, dependent: :destroy
	has_many :users
	has_many :events
	has_many :events, through: :places

	belongs_to :city

end
