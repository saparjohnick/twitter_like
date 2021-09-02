class Micropost < ApplicationRecord
  belongs_to :user

  attr_accessor :is_delayed, :pub_date

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
end
