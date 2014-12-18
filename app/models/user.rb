class User < ActiveRecord::Base
  require_relative '../domain/usecases/events/get_events'
  require_relative '../domain/usecases/level/get_level'
  require_relative '../domain/usecases/level/points_level'
  require_relative '../domain/usecases/level/icon_level'
  require_relative '../domain/usecases/friends/get_friends'
  require_relative '../domain/usecases/friends/ranking_friends'


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


  def events_from_neighborhood
    Villeme::UseCases::GetEvents.from_neighborhood(self)
  end

  def quantity_of_events_from_neighborhood
    Villeme::UseCases::GetEvents.quantity_from_neighborhood(self)
  end

  def my_neighborhood_has_events?
    Villeme::UseCases::GetEvents.neighborhood_has_events?(self)
  end

  def events_from_persona
    Villeme::UseCases::GetEvents.from_persona(self)
  end

  def quantity_of_events_from_persona
    Villeme::UseCases::GetEvents.quantity_of_events_from_persona(self)
  end

  def level_icon_url
    Villeme::UseCases::IconLevel.get_icon(self)
  end


  def next_level
    Villeme::UseCases::GetLevel.next_level(self)
  end

  def points_to_next_level
    Villeme::UseCases::PointsLevel.points_to_next_level(self)
  end

  def percentage_of_current_level
    Villeme::UseCases::GetLevel.percentage_of_current_level(self)
  end


  # Verifica se o evento foi agendado pelo usuario
  def agended?(event)
    self.agenda_events.include?(event) ? true : false
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


  def friends_from_facebook_on_villeme
    Villeme::UseCases::GetFriends.friends_from_facebook_on_villeme(self)
  end

  def ranking_of_friends
    Villeme::UseCases::RankingFriends.get_ranking(self)
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


  def newsfeed_notify
    Villeme::UseCases::NewsfeedNotify.get_notifies(self)
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

