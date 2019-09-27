class Gram < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :message, presence: true


  belongs_to :user
end
