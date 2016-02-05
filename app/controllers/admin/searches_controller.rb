class Admin::SearchesController < Admin::AdminController
  def index
    @searches = Search.all
  end
end
