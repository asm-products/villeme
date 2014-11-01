# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    # Gamificação
    require 'gamification.rb'
    include Gamification

    def initialize

      # Eventos
      
      score 10, on: 'events#create' do |event|
        user = event.user
        level_up(user)
      end

      score 1, on: 'events#update' do |event|
        user = event.user
        level_up(user)
      end


      # Feedback
      
      score 1, on: 'feedback#create' do |feedback|
        user = feedback.user
        level_up(user)
      end  

    end
  end
end
