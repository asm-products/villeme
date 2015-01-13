require 'rails_helper'
require_relative '../../app/domain/usecases/users/set_locale'

describe 'UseCases::SetLocale' do

  describe '#set_locale' do

    context 'when user is logged in' do
      context 'when current_user have a :locale' do
        before(:each) do
          @user = double('User', locale: :'pt-BR')
          I18n.locale = :en
        end

        subject{ Villeme::UseCases::SetLocale.new(@user).set_locale }

        it 'should settable I18n.locale = @user.locale' do
          Villeme::UseCases::SetLocale.new(@user).set_locale
          expect(I18n.locale).to eq(@user.locale)
        end

        it 'should return true if settable is successful' do
          is_expected.to be_truthy
        end
      end

      context 'when current_user DO NOT have :locale and controller have :locale parameter' do
        before(:each) do
          @user = double('User', locale: nil)
          @params = {locale: :fr}
          I18n.locale = :en
        end

        subject{ Villeme::UseCases::SetLocale.new(@user).set_locale(@params) }

        it 'should i18n.locale settable equal parameter' do
          Villeme::UseCases::SetLocale.new(@user).set_locale(@params)
          expect(I18n.locale).to eq(:fr)
        end

        it 'should return true if settable is successful' do
          is_expected.to be_truthy
        end
      end

      context 'when current_user DO NOT have a :locale, controller DO NOT have parameter AND @user have an ip' do
        before(:each) do
          @user = double('User', locale: nil, ip: '177.18.147.47')
          @params = nil
          I18n.locale = :en
        end

        it 'should return country_code from Geocoder using @user ip' do
          Villeme::UseCases::SetLocale.new(@user).set_locale(@params)
          expect(I18n.locale).to eq(:'pt-BR')
        end
      end
    end
    
    context 'when user is NOT logged in' do
      before(:each) do
        @user = nil
        @user_ip = '177.18.147.47'
        I18n.locale = :en
      end

      it 'should settable I18n.locale from your ip' do
        Villeme::UseCases::SetLocale.new(@user).set_locale_from_ip(@user_ip)
        expect(I18n.locale).to eq(:'pt-BR')
      end
    end

  end

end