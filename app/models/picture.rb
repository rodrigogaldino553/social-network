class Picture < ApplicationRecord
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:non_approved) if self.roles.blank?

    # call send email to admins here
  end

  #agora como no corsego, acho que cria uma rota pra um controller, e chama esse metodo de la
  def approve
    self.remove_role(:non_approved)
    self.add_role(:approved)

    # call send email to user, to advice that picture was successfull
  end

  rolify

  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :photo, attached: true,
    content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'File selected is not a valid image' },
    size: { less_than: 3.megabytes, message: 'Is too large' }

  validates :legend, length: { maximum: 256 }
end
