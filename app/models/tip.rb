class Tip < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  # Validações
  validates :description, presence: true, length: {maximum: 140}
  validates :event_id, presence: true
  validate :tip_limit, on: :create


  private

  def tip_limit
	  tips_count = self.event.tips.where(user_id: self.user.id).count
    if tips_count >= 2
	    errors.add(:base, "2 dicas por pessoa.")
	  end  
  end


end
