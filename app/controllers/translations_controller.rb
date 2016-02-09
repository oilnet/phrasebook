class TranslationsController < ApplicationController
  before_action :set_translation, only: [:show]

  # GET /translations/1.mp3
  def show
    respond_to do |format|
      format.mp3 { send_data(
        @translation.recording_data, 
        type: :mp3, 
        filename: @translation.recording_filename
      )}
    end
  end

  private

  def set_translation
    @translation = Translation.find(params[:id])
  end
end
