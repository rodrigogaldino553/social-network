class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy like unlike approve disapprove ]
  skip_before_action :authenticate_user!, only: [:index]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all.order(created_at: :desc)
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    # @likes = Like.where(picture_id: @picture.id).where(like: true)
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
    authorize @picture
  end

  # POST /pictures or /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    respond_to do |format|
      if @picture.save
        format.html { redirect_to pictures_path, notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to pictures_path, notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    authorize @picture
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    # @like = @picture.likes.where(user: current_user).first_or_create
    # @like.like = true

    # respond_to do |format|
    #   format.turbo_stream { render turbo_stream: turbo_stream.replace(@like) }
    #   format.html { redirect_to @picture }
    # end
    
    @user = current_user.id
    @existent_like = @picture.likes.find_by(user_id: @user)
    unless @existent_like.nil?
      @existent_like.update_attribute(:like, true)
    else
      @like = Like.new picture_id: @picture.id, user_id: @user, like: true
      @like.save
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@picture, partial: 'pictures/picture', locals: {picture: @picture})
      end
      format.html do
        redirect_to @picture
      end
      #format.html { redirect_to pictures_path }
    end
  end

  def unlike
    # @like = @picture.likes.where(user: current_user).destroy_all
    # render :create
    @like = @picture.likes.find_by(user_id: current_user)
    @like.update_attribute(:like, false)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@picture, partial: 'pictures/picture', locals: {picture: @picture})
      end
      format.html do
        redirect_to @picture
      end
      # format.html { redirect_to pictures_path }
    end
  end

  def privacy_policy
  end

  def approve
    @picture.approve
    
  end

  def disapprove
    @picture.disapprove
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:legend, :photo)
    end
end
