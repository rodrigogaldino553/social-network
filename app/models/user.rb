class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :pictures_url

  validates :avatar, attached: true,
    content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'File selected is not a valid image' },
    size: { less_than: 3.megabytes, message: 'Is too large' }

  validates :name, presence: true, length: { maximum: 15 }
  validates :name, presence: true
  validates :description, length: { maximum: 30 }

  # validates email

  def username
    # logic to split user email at @ and take the fisrt part
    self.email.split(/@/).first
  end

  def show_avatar
    return 'https://hey-brow.herokuapp.com/assets/padrao.png' unless self.avatar.attached?
    self.avatar
  end
end
