class Picture < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :photo, attached: true,
    content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'File selected is not a valid image' },
    size: { less_than: 3.megabytes, message: 'Is too large' }

  validates :legend, length: { maximum: 256 }
end
