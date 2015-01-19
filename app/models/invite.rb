class Invite < ActiveRecord::Base

  require_relative '../../app/domain/usecases/geolocalization/geocode_invite'
  require_relative '../../app/domain/usecases/cities/city_goal_decrease'

  after_validation :geocode_invite, unless: 'address.nil?'

  include GeocodedActions

	# associações
  belongs_to :user

  # validações
  validates :name, presence: true, length: 1..140
  validates :email, presence: true, length: 6..140
  validates :persona, presence: true, length: {maximum: 10}, if: lambda {self.persona_sugest.blank?}
  validates :persona_sugest, length: {maximum: 140}

  def geocode_invite
    Villeme::UseCases::GeocodeInvite.new(self).geocoded_by_address(self.address)
    Villeme::UseCases::CityGoalDecrease.new(self.city).decrease unless Rails.env.test?
  end


end
