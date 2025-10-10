class CategoriesController < ApplicationController
  before_action :set_categorie, only: [ :show ]
  def index
    @categories = Category.all
  end

  def show
  end

  private

  def set_categorie
    @category = Category.find(params[:id])
  end
end
