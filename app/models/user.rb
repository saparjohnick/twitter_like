class User < ApplicationRecord
  extend FriendlyId
  # attr_accessor :name, :email, :password, :password_confirmation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
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

end
