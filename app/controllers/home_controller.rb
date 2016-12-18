class HomeController < ApplicationController
  def index
  	redirect_to products_list_path
  end
end
