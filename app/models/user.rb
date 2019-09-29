class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :grams
  has_many :comments

  def username
    email_array = self.email.chars
    return email_array.split("@")[0].join("")
  end
end
