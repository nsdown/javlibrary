class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :actors, -> { distinct }


  def follow(actor_id)
    self.actors << Actor.find(actor_id) unless self.actors.include?(Actor.find(actor_id))
  end

  def unfollow(actor_id)
    self.actors.delete(Actor.find(actor_id)) if self.actors.include?(Actor.find(actor_id))
  end

  def following?(other_actor)
    self.actors.include?(other_actor)
  end
end
