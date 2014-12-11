class User < ActiveRecord::Base


  has_merit
  ratyrate_rater

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  extend FacebookOauth
  extend  GeocodedByAddress
  include GeocodedActions

  geocoder_by_address

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :avatar => "38x38" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #omniAuth com devise
  devise :omniauthable, :omniauth_providers => [:facebook]

  # associações

  belongs_to :level
    delegate :name, to: :level, prefix: true, allow_nil: true
    delegate :nivel, to: :level, prefix: true, allow_nil: true

  belongs_to :persona
    delegate :name, to: :persona, prefix: true

  has_one :notify

  has_many :events
  has_many :feedbacks
  has_many :tips

  has_many :agendas
  has_many :agenda_events, -> { uniq }, through: :agendas, source: :event

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :accepted_friendships,
          -> { where confirmed: true },
          class_name: 'Friendship'
  has_many :accepted_friends,
          through: :accepted_friendships,
          source: :friend,
          foreign_key: :friend_id  
  has_many :requested_friendships, 
          -> { where status: 'requested', confirmed: false},
          class_name: 'Friendship'
  has_many :requested_friends, 
          through: :requested_friendships,
          source: :friend,
          foreign_key: :friend_id              
  has_many :pending_friendships, 
          -> { where status: 'pending', confirmed: false },
          class_name: 'Friendship'
  has_many :pending_friends, 
          through: :pending_friendships,
          source: :friend,
          foreign_key: :friend_id


  def first_name
    self.name.split.first
  end


  def localize_from_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '123.45.67.89'
    else
      Geocoder.search("#{request.remote_ip}").first.coordinates
    end
  end


  def coordinates
    [latitude, longitude]
  end


  def events_from_my_neighborhood
    unless neighborhood.nil?
      neighborhood = Neighborhood.find(self.neighborhood)
      neighborhood.events
    end
  end


  def events_from_my_neighborhood_count
    if events_from_my_neighborhood
      events_from_my_neighborhood.count
    else
      0
    end
  end


  def events_from_my_persona
    persona = Persona.find(self.persona.id)
    persona.events
  end  


  # Url do icone do level atual do usuario
  def level_icon_url
    unless self.level.nil?
      self.level.icon.url(:original)
    end
  end


  # Pontos que faltam para o proximo level
  def points_to_next_level
    unless level.nil?
      (level.next.points).to_i - (points).to_i
    end
  end



  # Verifica se o evento foi agendado pelo usuario
  def agended?(event)
    self.agenda_events.include?(event) ? true : false
  end



  def percentage_of_level
    unless level.nil?
      ((points - level.points) * 100) / (level.next.points - level.points)
    end
  end



  def are_friends?(friend)
    self.accepted_friends.exists?(friend)
  end


  # Se o usuario possui convites de amizade
  def are_friedship_invite?(friend)
    self.pending_friends.exists?(friend)
  end


  # Pega os amigos do facebook que estão no villeme
  def friends_from_facebook

    if token

      # Array de retorno
      friends_from_facebook = Array.new

      # Pega os amigos do facebook via koala
      graph = Koala::Facebook::API.new(self.token)
      friends = graph.get_connections("me", "friends?fields=id,name,picture.type(square)")

      # Retorna 15 amigos
      friends[0..15]
    else
      false
    end

  end


  # Pega os amigos do facebook que estão no villeme
  def friends_from_facebook_on_villeme
    
    # Array de retorno
    friends_from_facebook = Array.new

    # Pega os amigos do facebook via koala
    graph = Koala::Facebook::API.new(self.token)
    friends = graph.get_connections("me", "friends?fields=id,name,picture.type(square)")

    # Testa cada amigo do facebook para ver se esta na plataforma
    friends.each do |fb_friend| 

      # compara o nome dos usuarios de facebook e da plataforma
      self.city.users.each do |friend| 
        if fb_friend["name"].split.first == friend.first_name 

          # friend_user = User.where("name like ?", "%#{friend["name"].split.first}%").first 
          if self.are_friends?(friend) == false and self.are_friedship_invite?(friend) == false 
            friends_from_facebook << friend
          end 
        end 
      end 
    end

    friends_from_facebook

  end


  # Retorna os amigos em un ranking ordenado por pontos
  def ranking_friends
    ranking_array = Array.new

    self.accepted_friends[0..25].each do |friend|
      friend_attributes = {id: friend.id, name: friend.name, points: friend.points, slug: friend.slug}
      ranking_array << friend_attributes
    end

    ranking_array << {id: self.id, name: self.name, points: self.points}
    ranking_array = ranking_array.sort_by{|obj| obj[:points]}.reverse!
  end


  def which_friends_will_this_event?(event)
    friends = self.accepted_friends
    friends_will_this_event = Array.new
    friends.each do |friend|
      if friend.agended?(event)
        friends_will_this_event << friend
      end
    end
    friends_will_this_event
  end



  def requested_friendships_notify
    if self.notify.nil?
      self.requested_friendships.where("created_at BETWEEN ? AND ?", DateTime.current - 365, DateTime.current)
    else
      self.requested_friendships.where("created_at BETWEEN ? AND ?", self.notify.bell_view, DateTime.current)
    end
  end



  # notificações de eventos no newsfeed não vistos
  def newsfeed_notify
    if self.has_notify
      if self.notify.newsfeed_view.blank?
        notify_date = DateTime.current - 300
      else
        notify_date = self.notify.newsfeed_view
      end
      Event.where("created_at BETWEEN ? AND ?", notify_date, DateTime.current)
    end
  end

  def newsfeed_notify_count
    if self.has_notify
      self.newsfeed_notify.count
    else
      0
    end
  end

  def has_notify
    if self.notify.nil?
      false
    else
      true
    end
  end


end

