class ReviewMailer < ApplicationMailer
  default from: ENV["EMAIL"]

  def post_review_email
    @user = params[:user]
    @picture = params[:picture]
    @admins = []
    User.all.filter { |user|  @admins << user.email if user.has_role?(:admin) }

    @admins.each do |admin|
      mail(to: admin, subject: "Some user uploaded a photo, REVIEW IT!")
    end
  end
end