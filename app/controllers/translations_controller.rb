# == Schema Information
#
# Table name: translations
#
#  id              :integer          not null, primary key
#  phrase_id       :integer
#  text            :text
#  transliteration :text
#  recording_data  :binary
#  language        :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class TranslationsController < ApplicationController
  before_action :set_translation, only: [:show]
  skip_before_filter :require_login

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
