# encoding: utf-8

class Event < ActiveRecord::Base

	ratyrate_rateable "geral"

	# Url bonita
  extend FriendlyId
  friendly_id :name, use: :slugged



	# Geocoder
	geocoded_by :address do |event_obj, results|
		if geo  = results.first
			event_obj.latitude = geo.latitude
			event_obj.longitude = geo.longitude
			event_obj.postal_code = geo.postal_code
			event_obj.neighborhood_name = geo.address_components_of_type(:neighborhood).first["long_name"]
			event_obj.city_name = geo.city
			event_obj.state = geo.state
			event_obj.state_code = geo.state_code
			event_obj.country = geo.country
			event_obj.country_code = geo.country_code
			event_obj.number = geo.street_number
			event_obj.full_address = geo.address
		end
	end

	after_validation :geocode


	# Associações
	belongs_to :place
	belongs_to :user
	belongs_to :price
	belongs_to :neighborhood
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


	# Validações FORMULARIO
	validates :name, presence: true, uniqueness: true, length: 6..140
	# validates :description, presence: true, length: 140..5000
	# validates :address, presence: true, unless: "address.nil?"
	# validates :hour_start_first, presence: true
	# validates :date_start, presence: true
	validates :cost, length: {maximum: 8}
	validates :cost_details, length: {maximum: 300}
	validates :email, allow_blank: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :link, length: {maximum: 300}
	validates :phone, length: {maximum: 20}
	# validates_attachment_presence :image
	# validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


	# Validações ASSOCIAÇÔES
	# validates_associated :event, :user




	# scopes

	# busca oe eventos que irão acontecer em uma
	# semana e que estão acontecendo
	# e filtra somente os moderados
	scope :upcoming, lambda {
	  where('date_start >= ? AND date_finish >= ? AND moderate = 1 OR date_start <= ? AND date_finish >= ? AND moderate = 1', Date.current - 7, Date.current, Date.current, Date.current).order(:date_start)
	}



	def name_with_limit
		name = self.name
		if name.length > 45
			return "#{name[0..45]}..."
		else
			name
		end
	end


	def description_with_limit
		name = self.name
		description = ActionController::Base.helpers.strip_tags(self.description)
		if name.length > 25
			return "#{description[0..70]}..."
		else
			return "#{description[0..100]}..."
		end
	end


	def get_city
		if self.place.neighborhood.city
			self.place.neighborhood.city
		elsif self.neighborhood.city
			self.neighborhood.city
		else
			nil
		end
	end


	def agended_by_count
		number = self.agended_by.count
		if number == 0
			respota = {valid: false, count: ""}
		elsif number == 1
			respota = {valid: true, count: 1, text: "1 pessoa agendou"}
		else
			respota = {valid: true, count: number, text: "#{number} pessoas agendaram"}
		end

		return respota
	end


	def period
		return "#{self.date_start.strftime("%d/%m")} - #{self.date_finish.strftime("%d/%m")}"
	end


	# Retorna o dia da semana que o evento acontece

	def day_of_week(options = {})
    date_start = self.date_start
    date_finish = self.date_finish
    today_in_week = Week.find_by(binary: Date.current.strftime("%w"))
    tomorrow_in_week = Week.find_by(binary: (Date.current + 1).strftime("%w"))

    if Date.current.between?(date_start, date_finish)
      if self.weeks.include?(today_in_week)
        return ("<span title='#{self.period}' class='label day today has-tooltip #{options[:css]}'>Hoje</span>").html_safe
      elsif self.weeks.include?(tomorrow_in_week)
        return ("<span title='#{self.period}' class='label day tomorrow has-tooltip #{options[:css]}'>Amanhã</span>").html_safe
      else
        return ("<span title='#{self.period}' class='label day has-tooltip #{options[:css]}'>#{self.weeks.first.name}</span>").html_safe
      end

    elsif date_start == Date.current.tomorrow
      return ("<span title='#{self.period}' class='label day tomorrow has-tooltip #{options[:css]}'>Amanhã</span>").html_safe

    else
      ("<span title='#{self.period}' class='label day tomorrow has-tooltip #{options[:css]}'>#{I18n.localize date_start, format: '%A'}</span>").html_safe
    end
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

		unless rates.empty?
			rates.average(:stars).to_f
		else
			nil
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



	def copy_attributes_to(place)
    place.address = self.address
    place.number = self.number
    place.neighborhood_name = self.neighborhood_name
    place.city_name = self.city_name
    place.postal_code = self.postal_code
    place.state = self.state
    place.state_code = self.state_code
    place.country = self.country
    place.country_code = self.country_code
    place.full_address = self.full_address
    place.latitude = self.latitude
    place.longitude = self.longitude
	end



end


