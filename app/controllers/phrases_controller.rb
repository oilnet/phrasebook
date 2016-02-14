# == Schema Information
#
# Table name: phrases
#
#  id            :integer          not null, primary key
#  tags          :string
#  usefulness    :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  approved      :boolean          default(FALSE)
#  image_data    :binary
#  image_source  :string
#  image_license :string
#

class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]
  skip_filter :require_login, only: [:index, :show, :new, :create]

  # GET /phrases
  def index
    if params[:search] && !params[:search].empty?
      @phrases = Phrase.approved.search(params[:search])
      Search.add(params[:search])
    elsif params[:tags]
      @phrases = Phrase.approved.tag_field(params[:tags])
    else
      @phrases = Phrase.approved.useful
    end
  end

  # GET /phrases/1.jpg
  def show
    respond_to do |format|
      format.jpg {send_data(@phrase.image_data, type: 'image/jpeg', filename: "#{@phrase.id}.jpg", disposition: 'inline')}
    end
  end
  
  private
  
  def set_phrase
    @phrase = Phrase.find(params[:id])
  end
end
