# encoding: utf-8
class Event < ActiveRecord::Base

	require_relative '../domain/usecases/events/event_attributes'
	require_relative '../domain/usecases/geolocalization/get_geocoder_attributes'
	require_relative '../domain/usecases/geolocalization/geocode_event'

	after_validation :geocode_event, unless: 'address.nil?'

	ratyrate_rateable "geral"

	extend FriendlyId
	friendly_id :name, use: :slugged

	include GeocodedActions


	# Associações
	belongs_to :place
	belongs_to :user
	belongs_to :price
	belongs_to :persona
	belongs_to :subcategory
	has_and_belongs_to_many :categories
	has_and_belongs_to_many :weeks

	has_many :agendas
	has_many :agended_by, through: :agendas, source: :user

	has_many :tips

	# Avisa a classe que possui imagem no POST
	has_attached_file :image

	accepts_nested_attributes_for :place


	# gem paperclip
	has_attached_file :image,
                    styles: {thumb: "280x280>", medium: "800x300>"},
                    default_url: "/images/:style/missing.png"



	validates :name, presence: true, uniqueness: true, length: 6..140
	validates :description, allow_blank: true, length: 10..5000
	validates :address, presence: true, length: {maximum: 200}, unless: Proc.new {|event| Place.find_by(name: event.address).nil?}
	validates :hour_start_first, presence: true
	validates :date_start, presence: true
	validates :cost, length: {maximum: 8}
	validates :cost_details, length: {maximum: 300}
	validates :email, allow_blank: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :link, length: {maximum: 300}
	validates :phone, length: {maximum: 20}
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


	# scopes

	# busca oe eventos que irão acontecer em uma
	# semana e que estão acontecendo
	# e filtra somente os moderados
	scope :upcoming, lambda {
	  where('date_start >= ? AND date_finish >= ? AND moderate = 1 OR date_start <= ? AND date_finish >= ? AND moderate = 1', Date.current - 7, Date.current, Date.current, Date.current).order(:date_start)
	}



	def name_with_limit
		Villeme::UseCases::EventAttributes.name_with_limit(self)
	end

	def description_with_limit
		Villeme::UseCases::EventAttributes.description_with_limit(self)
	end

	def relative_latitude
		Villeme::UseCases::GeocoderAttributes.relative_latitude(self)
	end

	def relative_longitude
		Villeme::UseCases::GeocoderAttributes.relative_longitude(self)
	end

	def price
		Villeme::UseCases::EventAttributes.price(self)
	end

	def agended_by_count
		number = self.agended_by.count
		if number == 0
			respota = {valid: false, count: ""}
		elsif number == 1
			respota = {valid: true, count: 1, text: '1 pessoa agendou'}
		else
			respota = {valid: true, count: number, text: "#{number} pessoas agendaram"}
		end

		return respota
	end


	def period_that_occurs
    Villeme::UseCases::EventAttributes.period_that_occurs(self)
	end


	# Retorna o dia da semana que o evento acontece

	def day_of_week(options = {})

		require_relative '../../app/domain/usecases/weeks/get_day_of_week'
		require_relative '../../app/domain/usecases/dates/get_next_day_occur_human_readable'

		Villeme::UseCases::Dates.get_next_day_occur_human_readable(self)
	rescue
		nil
  end


	# Retorna os dias da semana que o evento acontece

	def days_of_week

		# array para retorno
		days_of_event = Array.new

		# pega os dias da semana do evento
		week_of_event = self.weeks.select([:id, :name, :slug])
		week = Week.all.select([:id, :name, :slug])

		# compara os dias do evento com o de uma semana comum
		week.each do |day|
			if week_of_event.include? day
				days_of_event << "<span class='label white-bg border'>#{day.name}</span>"
			else
				days_of_event << "<span class='label white-bg border has-tooltip' title='Neste dia o evento não ocorre'><s>#{day.name}</s></span>"
			end
		end

		return "#{days_of_event.join(' ')}".html_safe
	end


	# Retorna a media da votação
	def rate_media
		# Pega as votações
		rates = Rate.where(rateable_id: self.id)

    if rates.empty?
      nil
    else
      rates.average(:stars).to_f
    end
	end

	# Numero de pessoas que votaram
	def rates_count
		# Pega as votações
		rates = Rate.where(rateable_id: self.id)

		if rates.empty?
			"Seja o primeiro a avaliar"
		else
			"#{rates.count}"
		end
	end

	def geocode_event
		Villeme::UseCases::GeocodeEvent.new(self).geocoded_by_address(self.address)
	end



end


