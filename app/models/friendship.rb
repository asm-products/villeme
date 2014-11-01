class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"



  def self.request(user, friend)
    unless user == friend and user.are_friend?(friend)
      transaction do
        create(:user => user, :friend => friend, :status => 'pending')
        create(:user => friend, :friend => user, :status => 'requested')
      end
    end
  end

  def self.accept(user, friend)
    transaction do
      accepted_at = Time.current
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  def self.accept_one_side(user, friend, accepted_at)
    request = self.find_by_user_id_and_friend_id(user, friend)
    request.confirmed = true
    request.accepted_at = accepted_at
    request.save!
  end


  def self.destroy(user, friend)
    transaction do
      destroy_one_side(user, friend)
      destroy_one_side(friend, user)
    end
  end

  def self.destroy_one_side(user, friend)
    request = self.find_by_user_id_and_friend_id(user, friend)
    request.destroy
  end

end
