class City < ActiveRecord::Base

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  include GeocodedActions

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
        :name,
        [:name, :id]
    ]
  end

  def users
    User.where(city_name: name)
  end

  def neighborhoods
    Neighborhood.where(city_name: name)
  end

  def events
    Event.where(city_name: name)
  end

end
