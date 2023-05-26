class User < ApplicationRecord
  after_create :assign_default_role
  before_create :generate_permalink

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
    self.add_role(:admin) if User.count == 0
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  rolify

  has_one_attached :avatar
  has_many :pictures_url
  has_many :comments, dependent: :nullify

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :avatar, 
      content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'File selected is not a valid image' },
      size: { less_than: 3.megabytes, message: 'Is too large' }

  validates :name, presence: true, length: { maximum: 15 }
  validates :status, length: { maximum: 30 }

  def username
    # logic to split user email at @ and take the fisrt part
    self.email.split(/@/).first
  end

  def to_param
    self.permalink
  end

  private

    def generate_permalink
      self.permalink = SecureRandom.hex(8)
    end
end
