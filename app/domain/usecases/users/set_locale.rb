module Villeme
  module UseCases
    class SetLocale

      def initialize(entity = nil)
        @user = entity
      end

      def set_locale(params = nil)
        if params
          set_i18n_locale_equal_parameter_locale(params)
        elsif @user.locale
          set_i18n_locale_equal_user_locale
        elsif @user.ip
          set_i18n_locale_from_user_ip(@user.ip)
        else
          set_i18n_locale_equal_default_locale
        end
      end

      def set_locale_from_ip(requested_ip)
        @user_ip = requested_ip
        set_i18n_locale_from_user_ip(@user_ip)
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

      def set_i18n_locale_from_user_ip(ip)
        I18n.locale = Geocoder.search(ip).first.country_code.downcase
        true
      end

      def set_i18n_locale_equal_default_locale
        I18n.locale = I18n.default_locale
        false
      end

    end
  end
end