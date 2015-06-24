class Invite < ActiveRecord::Base

  require_relative '../../app/domain/usecases/geolocalization/geocode_invite'  

  after_validation :geocode_invite, unless: 'address.nil?'

  include GeocodedActions

	# associações
  belongs_to :user

  # validações
  validates :name, presence: true, length: 1..140
  validates :email, presence: true, length: 6..140
  validates :persona, presence: true


  def geocode_invite
    Villeme::UseCases::GeocodeInvite.new(self).geocoded_by_address(self.address)
  end


end
