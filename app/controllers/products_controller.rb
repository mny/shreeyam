class ProductsController < ApplicationController
  def index
    @products_grid = initialize_grid(Product,
                       :order => 'products.id' ,
                       :order_direction => 'desc',
                       :per_page => 6 ,
                       :name => 'g1',
                       :enable_export_to_csv => true ,
                       :csv_field_separator => ';',
                       :csv_file_name => 'purchases'
                       )

    export_grid_if_requested('g1' => 'grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
    @product = Product.new
  end

  def list
    @products_grid = initialize_grid(Product,
                       :order => 'products.id' ,
                       :order_direction => 'desc',
                       :per_page => 9 ,
                       :name => 'g1',
                       :enable_export_to_csv => true ,
                       :csv_field_separator => ';',
                       :csv_file_name => 'purchases'
                       )

    export_grid_if_requested('g1' => 'grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
    @product = Product.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product].permit(:name, :item_code, :description, 
                                                   :real_price , 
                                                   :sale_price ,
                                                   :variable_cost_percent ,
                                                   :quantity ,
                                                   :cost_at_supplier ,
                                                   :exchange_rate
                                                   ))
    @product.real_price = @product.get_real_price
    @product.quantity_godown = @product.quantity
    @product.cost_price = @product.get_cost_price
    if @product.save!
      flash[:error] = nil
      flash[:notice] = 'Thank you for your input!'
    end
  rescue => e
    flash[:error] = e.to_s
  ensure
    redirect_to products_path
  end

  def destroy
  end

  def update
    @product = Product.find(params[:id])
    @product.attributes = params[:product].permit( :name, 
                                                   :item_code, 
                                                   :real_price , 
                                                   :sale_price ,
                                                   :quantity ,
                                                   :quantity_godown ,
                                                   :quantity_shop ,
                                                   :variable_cost_percent ,
                                                   :added_no_of_items ,
                                                   :no_of_items_moved_to_shop ,
                                                   :description ,
                                                   :cost_at_supplier ,
                                                   :exchange_rate
                                                  )
     @product.real_price = @product.get_real_price
    if @product.added_no_of_items
      @product.quantity+= @product.added_no_of_items.to_f
      @product.quantity_godown+= @product.added_no_of_items.to_f
    elsif @product.no_of_items_moved_to_shop
      @product.quantity_godown-=  @product.no_of_items_moved_to_shop.to_f
      @product.quantity_shop+= @product.no_of_items_moved_to_shop.to_f
    else
      @product.cost_price = @product.get_cost_price
    end
    @product.save

    redirect_to products_path
  end

  def show
  end

  def edit
    @product = Product.find(params[:id])
  end

  def purchase
    @product = Product.find(params[:id])
  end

  def to_shop
    @product = Product.find(params[:id])
  end
end
