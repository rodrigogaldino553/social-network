class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :pictures_url

  validates :name, length: { maximum: 15 }
  validates :description, length: { maximum: 30 }

  # validates email

  def username
    # logic to split user email at @ and take the fisrt part
    self.email.split(/@/).first
  end
end
