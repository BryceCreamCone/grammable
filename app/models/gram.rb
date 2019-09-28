class Gram < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :message, presence: true
  validates :image, presence: true


  belongs_to :user
  has_many :comments
end
