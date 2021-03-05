class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :visiteds
  has_many :favourites
  has_many :ratings
  has_many :comments
  has_many :megalith_photos
  has_many :trip_users
  has_many :trips, through: :trip_users
  has_one_attached :photo

  def visited
    self.visiteds.map(&:megalith)
  end

  def favourited
    self.favourites.map(&:megalith)
  end

  include PgSearch::Model
  pg_search_scope :search_users,
    against: [:email, :username],
    using: {
      tsearch: { prefix: true }
    }
end
