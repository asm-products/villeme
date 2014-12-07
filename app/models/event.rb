# encoding: utf-8

class Event < ActiveRecord::Base

	ratyrate_rateable "geral"
	
  extend FriendlyId
  friendly_id :name, use: :slugged

	include Geocoderize



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
      "#{name[0..45]}..."
		else
			name
		end
	end


	def description_with_limit
		name = self.name
		description = ActionController::Base.helpers.strip_tags(self.description)
		if name.length > 25
      "#{description[0..70]}..."
		else
      "#{description[0..100]}..."
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

	def neighborhood
		Neighborhood.find_by(name: neighborhood_name)
	end

	def city
		City.find_by(name: city_name)
	end

  def get_longitude
    if longitude.blank?
      self.place.longitude
    else
      self.longitude
    end
  end


  def get_latitude
    if latitude.blank?
      self.place.latitude
    else
      self.latitude
    end
	end

	def get_cost
		if cost == 0 or cost.blank?
			"Gratuito"
		else
			cost
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
    "#{self.date_start.strftime("%d/%m")} - #{self.date_finish.strftime("%d/%m")}"
	end


	# Retorna o dia da semana que o evento acontece

	def day_of_week(options = {})

    if weeks.any?
      today_in_week = Week.find_by(binary: Date.current.strftime("%w"))
      tomorrow_in_week = Week.find_by(binary: (Date.current + 1).strftime("%w"))

      if Date.current.between?(date_start, date_finish)
        if weeks.include?(today_in_week)
          return ("<span title='#{period}' class='label day today has-tooltip #{options[:css]}'>Hoje</span>").html_safe
        elsif weeks.include?(tomorrow_in_week)
          return ("<span title='#{period}' class='label day tomorrow has-tooltip #{options[:css]}'>Amanhã</span>").html_safe
        else
          return ("<span title='#{period}' class='label day has-tooltip #{options[:css]}'>#{self.weeks.first.name}</span>").html_safe
        end
      elsif date_start == Date.current.tomorrow
        return ("<span title='#{period}' class='label day tomorrow has-tooltip #{options[:css]}'>Amanhã</span>").html_safe
      else
        ("<span title='#{period}' class='label day tomorrow has-tooltip #{options[:css]}'>#{I18n.localize date_start, format: '%A'}</span>").html_safe
      end
    else
      nil
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






end


