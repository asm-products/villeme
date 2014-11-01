class FriendshipsController < ApplicationController


  # Requisição de amizade

  def request_friendship
    friend = User.friendly.find(params[:friend])
    action = Friendship.request(current_user, friend)

    if action
      expire_fragment [current_user, "friends_ranking"]
      render json: {friend_id: friend.id, success: true, text: "Amizade solicitada"}
    else
      render json: {success: false, text: "Erro"}
    end
  end




  def accept_friendship
    user = current_user
    friend = User.friendly.find(params[:friend])
    action = Friendship.accept(user, friend)
    
    if action
      expire_fragment [current_user, "friends_ranking"]
      render json: {success: true, friend_id: friend.id, text: "Amigo"}
    else
      render json: {success: false, text: "Erro"}
    end

  end



  def destroy_friendship
    friend = User.friendly.find(params[:friend])
    action = Friendship.destroy(current_user, friend)
    
    if action
      expire_fragment [current_user, "friends_ranking"]
      render json: {success: true, friend_id: friend.id, text: "Solicitar amizade"}
    else
      render json: {success: false, text: "Erro"}
    end    
  end


end
