class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @picture = Picture.find(params[:picture_id])

    @comment.picture_id = @picture.id
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to picture_path(@picture), notice: "Comment saved!" }
      else
        format.html { redirect_to picture_path(@picture), alert: "Can't save comment!" }
      end
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(picture_id: params[:picture_id])
  end
end
