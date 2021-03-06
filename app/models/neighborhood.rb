class Neighborhood < ActiveRecord::Base

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


  def events
    Event.where(neighborhood_name: name)
  end

  def places
    Place.where(neighborhood_name: name)
  end

end
