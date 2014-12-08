module GeocodedActions


  def copy_attributes_to(object)
    object.address = self.address
    object.number = self.number
    object.neighborhood_name = self.neighborhood_name
    object.city_name = self.city_name
    object.postal_code = self.postal_code
    object.state_name = self.state_name
    object.state_code = self.state_code
    object.country_name = self.country_name
    object.country_code = self.country_code
    object.full_address = self.full_address
    object.latitude = self.latitude
    object.longitude = self.longitude
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