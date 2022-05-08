class Picture < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :photo, attached: true,
    content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'File selected is not a valid image' },
    size: { less_than: 3.megabytes, message: 'Is too large' }
end
