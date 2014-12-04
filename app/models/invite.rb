class Invite < ActiveRecord::Base

	# associações
  belongs_to :user

  # validações
  validates :name, presence: true, length: 1..140
  validates :email, presence: true, length: 6..140
  validates :persona, presence: true, length: {maximum: 10}, if: lambda {self.persona_sugest.blank?}
  validates :city_sugest, length: {maximum: 140}
  validates :persona_sugest, length: {maximum: 140}



end
