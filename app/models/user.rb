class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  extend FriendlyId
  # attr_accessor :name, :email, :password, :password_confirmation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable

  before_save {self.email = email.downcase}
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: {minimum: 6}

  friendly_id :name, use: :slugged

  def to_param
    "#{id} #{name}".parameterize
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(another_user)
    active_relationships.create(followed_id: another_user.id)
  end

  def unfollow(another_user)
    active_relationships.find_by(followed_id: another_user.id).destroy
  end

  def is_following?(another_user)
    following.include?(another_user)
  end

end
