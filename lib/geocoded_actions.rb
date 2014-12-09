module GeocodedActions


  def copy_attributes_to(object)
    object.latitude = self.latitude
    object.longitude = self.longitude
    object.route = self.route
    object.neighborhood_name = self.neighborhood_name
    object.city_name = self.city_name
    object.state_name = self.state_name
    object.state_code = self.state_code
    object.country_name = self.country_name
    object.country_code = self.country_code
    object.postal_code = self.postal_code
    object.street_number = self.street_number
    object.full_address = self.full_address
    object.formatted_address = self.formatted_address

    object.save
  end


  def neighborhood
    Neighborhood.find_by(name: neighborhood_name)
  end

  def city
    City.find_by(name: city_name)
  end

  def state
    State.find_by(name: state_name)
  end

  def country
    Country.find_by(name: country_name)
  end

end