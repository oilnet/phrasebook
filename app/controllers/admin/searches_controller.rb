class Admin::SearchesController < Admin::AdminController
  def index
    @searches = Search.sorted
  end
  
  # DELETE /searches/1
  def destroy
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to admin_searches_path, notice: t('admin.searches.destroyed', default: 'Search deleted.')
  end
end
