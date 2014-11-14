# encoding: utf-8

class TipsController < ApplicationController
  def create
    @tip = Tip.new(tip_params)
    @tip.user_id = current_user.id
    if @tip.save
    	render json: {description: @tip.description,
                    user: view_context.link_to(@tip.user.name, @tip.user),
                    created_at: view_context.distance_of_time_in_words_to_now(@tip.created_at),
                    valid: true}
    else
    	render json: {valid: false}
    end
  end

  def destroy

  end

  private

  def tip_params
    params.require(:tip).permit(:description, :event_id, :user_id)
  end

end
