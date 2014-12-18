module Villeme
  module UseCases
    class GetFriends
      class << self

        def friends_from_facebook_on_villeme(entity)
          friends = get_graph_of_friends_from_facebook_via_koala(entity)

          friends.each do |fb_friend|
            compares_app_friends_to_facebook_friends(fb_friend, entity)
          end
        end



        private

        def compares_app_friends_to_facebook_friends(fb_friend, entity)
          list_of_friends_from_facebook ||= []

          entity.city.users.each do |friend|
            if fb_friend["name"].split.first == friend.first_name
              if entity.are_friends?(friend) == false and entity.are_friedship_invite?(friend) == false
                list_of_friends_from_facebook << friend
              end
            end
          end

          list_of_friends_from_facebook
        end


        def get_graph_of_friends_from_facebook_via_koala(entity)
          graph = Koala::Facebook::API.new(entity.token)
          graph.get_connections("me", "friends?fields=id,name,picture.type(square)")
        end

      end
    end
  end
end