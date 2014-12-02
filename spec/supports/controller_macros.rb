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

end