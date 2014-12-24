module ControllerMacros
  def set_admin_logged_in
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:admin) # Using factory girl as an example
    end
  end

  def set_user_logged_in
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  def set_current_user_nil
    allow(controller).to receive(:current_user).and_return(nil)
  end

  def fake_geocoder
    hash = {"address_components"=>[{"long_name"=>"544", "short_name"=>"544", "types"=>["street_number"]}, {"long_name"=>"Madison Avenue", "short_name"=>"Madison Ave", "types"=>["route"]}, {"long_name"=>"Park South", "short_name"=>"Park South", "types"=>["neighborhood", "political"]}, {"long_name"=>"Albany", "short_name"=>"Albany", "types"=>["locality", "political"]}, {"long_name"=>"Albany County", "short_name"=>"Albany County", "types"=>["administrative_area_level_2", "political"]}, {"long_name"=>"New York", "short_name"=>"NY", "types"=>["administrative_area_level_1", "political"]}, {"long_name"=>"United States", "short_name"=>"US", "types"=>["country", "political"]}, {"long_name"=>"12208", "short_name"=>"12208", "types"=>["postal_code"]}, {"long_name"=>"3614", "short_name"=>"3614", "types"=>["postal_code_suffix"]}], "formatted_address"=>"544 Madison Avenue, Albany, NY 12208, USA", "geometry"=>{"location"=>{"lat"=>42.6544568, "lng"=>-73.77161439999999}, "location_type"=>"ROOFTOP", "viewport"=>{"northeast"=>{"lat"=>42.6558057802915, "lng"=>-73.77026541970848}, "southwest"=>{"lat"=>42.6531078197085, "lng"=>-73.7729633802915}}}, "types"=>["street_address"]}
  end

end