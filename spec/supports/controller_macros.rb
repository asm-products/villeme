module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:admin) # Using factory girl as an example
    end
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end
end