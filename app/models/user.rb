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

  def recalculate_badge_scores
    upvotes = megalith_photos.map { |photo| photo.get_likes }.flatten.length
    self.photographer_score = megalith_photos.length + upvotes
    upvotes = comments.map { |comment| comment.get_likes }.flatten.length
    self.commenter_score = comments.length + upvotes
    upvotes = trips.map { |trip| trip.get_likes }.flatten.length
    self.tour_guide_score = trips.length + upvotes
    self.save
  end


  include PgSearch::Model
  pg_search_scope :search_users,
    against: [:email, :username],
    using: {
      tsearch: { prefix: true }
    }
end
