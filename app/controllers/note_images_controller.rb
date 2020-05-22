class NoteImagesController < ApplicationController
  before_action :set_note_image, only: [:show, :edit, :update, :destroy]

  # GET /note_images
  # GET /note_images.json
  def index
    @note_images = NoteImage.all
  end

  # GET /note_images/1
  # GET /note_images/1.json
  def show
  end

  # GET /note_images/new
  def new
    @note_image = NoteImage.new
  end

  # GET /note_images/1/edit
  def edit
  end

  # POST /note_images
  # POST /note_images.json
  def create
    @note_image = NoteImage.new(note_image_params)

    respond_to do |format|
      if @note_image.save
        format.html { redirect_to @note_image, notice: 'Note image was successfully created.' }
        format.json { render :show, status: :created, location: @note_image }
      else
        format.html { render :new }
        format.json { render json: @note_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_images/1
  # PATCH/PUT /note_images/1.json
  def update
    respond_to do |format|
      if @note_image.update(note_image_params)
        format.html { redirect_to @note_image, notice: 'Note image was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_image }
      else
        format.html { render :edit }
        format.json { render json: @note_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_images/1
  # DELETE /note_images/1.json
  def destroy
    @note_image.destroy
    respond_to do |format|
      format.html { redirect_to note_images_url, notice: 'Note image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_image
      @note_image = NoteImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_image_params
      params.require(:note_image).permit(:note_id, :image)
    end
end
