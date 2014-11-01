class Category < ActiveRecord::Base

	# Urls bonitas
  extend FriendlyId
  friendly_id :name, use: :slugged

	# associações
	has_and_belongs_to_many :events
	has_and_belongs_to_many :places


end
