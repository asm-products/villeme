module Villeme
  module UseCases
    class SetLocale

      def initialize(entity)
        @user = entity
      end

      def set_locale(params = nil)
        if @user.locale
          set_i18n_locale_equal_user_locale
        elsif params
          set_i18n_locale_equal_parameter_locale(params)
        elsif @user.ip
          set_i18n_locale_from_user_ip
        else
          set_i18n_locale_equal_default_locale
        end
      end


      private

      def set_i18n_locale_equal_user_locale
        I18n.locale = @user.locale
        true
      end

      def set_i18n_locale_equal_parameter_locale(params)
        I18n.locale = params[:locale]
        true
      end

      def set_i18n_locale_from_user_ip
        I18n.locale = Geocoder.search(@user.ip).first.country_code.downcase
        true
      end

      def set_i18n_locale_equal_default_locale
        I18n.locale = I18n.default_locale
        false
      end

      # def get_user_ip
      #   if request.remote_ip == '127.0.0.1'
      #     # For use in RAILS_ENV=teste
      #     '177.18.147.47'
      #   else
      #     @user.assign_attributes(ip: request.remote_ip) if current_user
      #   end
      # end


    end
  end
end