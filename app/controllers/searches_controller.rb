# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  text       :string
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchesController < ApplicationController
  # GET /searches
  def index
    @searches = Search.all
  end

  # POST /searches
  def create
    @search = Search.new(search_params)

    if @search.save
      redirect_to @search, notice: 'Search was successfully created.' # TODO: i18n: تم حفظ البحث الجديد
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def search_params
    params.require(:search).permit(:text)
  end
end
