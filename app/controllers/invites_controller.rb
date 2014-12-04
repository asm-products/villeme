# encoding: utf-8

class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # acesso somente para admin
  before_action :is_admin, except: :create
  

 

  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  # POST /invites.json
  def create

    # verifica se ja existe um convite com este email
    invite_exist = Invite.where(email: invite_params[:email]).first


    # se não existir cria o convite
    if invite_exist.blank?

      # classe para criar keys randomicas
      require 'securerandom'

      # criar uma key para url
      key = SecureRandom.urlsafe_base64
      values = invite_params
      values[:key] = key

      @invite = Invite.new(values)
      
      respond_to do |format|
        if @invite.save

          # Envia email de boas vindas
          InviteMailer.welcome_email(@invite).deliver

          format.html { redirect_to welcome_path, notice: values[:name].split.first + ', seu convite foi solicitado com sucesso. Enviaremos por email em breve.' }
          format.json { render action: 'show', status: :created, location: @invite }
        else
          format.html { redirect_to welcome_path, alert: 'Ops! Não foi possível criar seu convite, você preencheu todas as informações?' }
          format.json { render json: @invite.errors, status: :unprocessable_entity }
        end
      end

    else

      redirect_to welcome_path, notice: invite_params[:name].split.first + ', você já solicitou um convite. Assim que possível, lhe enviaremos por email.'

    end


  end

  # PATCH/PUT /invites/1
  # PATCH/PUT /invites/1.json
  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite, notice: 'Convite editado!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :no_content }
    end
  end


  # Envia o convite para o usuario
  def send_invite
    @invite = Invite.find_by(key: params[:key])
    # Envia email de boas vindas
    InviteMailer.send_key(@invite).deliver
    render js: "alert('Convite enviado!');"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
      params.require(:invite).permit(:user_id, :email, :name, :address, :persona, :persona_sugest, :city_sugest, :locale, :key)
    end
end
