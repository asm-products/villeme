module Villeme
  module UseCases
    class RankingFriends
      class << self

        def get_ranking(entity)
          ranking_array = get_list_of_friends(entity)
          reverse_ranking(ranking_array)
        end



        private


        def get_list_of_friends(entity)
          ranking_array ||= Array.new

          entity.accepted_friends[0..25].each do |friend|
            friend_attributes = {id: friend.id, name: friend.name, points: friend.points, slug: friend.slug}
            ranking_array << friend_attributes
          end

          add_entity_to_ranking_friends(entity, ranking_array)

          ranking_array
        end

        def add_entity_to_ranking_friends(entity, ranking_array)
          ranking_array << {id: entity.id, name: entity.name, points: entity.points}
        end

        def reverse_ranking(ranking_array)
          ranking_array.sort_by { |obj| obj[:points] }.reverse!
        end

      end
    end
  end
end