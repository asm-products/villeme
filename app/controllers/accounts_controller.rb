# encoding: utf-8

class AccountsController < ApplicationController

	before_action :current_user_home

	layout 'centralize'



  def edit
  	@user = current_user
  end


  def update

  	@user = current_user

  	account_completed @user 

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to newsfeed_path, notice: 'Você atualizou sua conta com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end  	
  end



  private

    def account_completed(user)
      user.update_attributes(account_complete: true)
    end

    def set_event
      @event = Event.find(params[:id])
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :username, :email, :avatar, :persona_id, :address)
    end  

end
