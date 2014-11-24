class Neighborhood < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slug_candidates

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
        :name,
        [:name, :id]
    ]
  end

end
