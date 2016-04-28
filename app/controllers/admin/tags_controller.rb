class Admin::TagsController < Admin::AdminController
  def index
    @tags = Tag.all
  end
end
