require 'rails_helper'

describe '/:id/account' do

  it 'should load user account' do
    user = double("User")
    allow(user).to receive(:id).and_return(1)

    expect(get: "/#{user.id}/account").to route_to(
                                              controller: 'accounts',
                                              action: 'edit',
                                              id: "1"
                                          )
  end

end