class SalesController < ApplicationController
  def index
    @sales_grid = initialize_grid(Sale,
                     :include => [:product],
                     :order => 'sales.id' ,
                     :order_direction => 'desc',
                     :per_page => 6 ,
                     :name => 'g1',
                     :enable_export_to_csv => true ,
                     :csv_field_separator => ';',
                     :csv_file_name => 'sales'
                     )
    export_grid_if_requested('g1' => 'grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(params[:sale].permit(:product_code, 
                                             :description, 
                                             :sold_price ,
                                             :quantity 
                                             ))
    @product = Product.where(["item_code = ?", @sale.product_code])
    raise "invalid product code" if @product.count == 0
    @sale.product_id = @product.first.id
    @sale.profit = @sale.get_profit
    if @sale.save!
      flash[:notice] = 'Thank you for your input!'
    end
  rescue => e
    flash[:error] = e.to_s
  ensure
    redirect_to sales_path
  end

  def new
    @sale = Sale.new
    if params[:format]
      @product = Product.find(params[:format])
      @sale.product = @product
      @sale.product_code = @product.item_code
    end
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    @sale.attributes = params[:sale].permit(:product_code, 
                                             :description, 
                                             :sold_price ,
                                             :quantity 
                                             )
    @product = @sale.product
    @sale.profit = @sale.get_profit
    @sale.save!
    redirect_to sales_path
  rescue => e
    flash[:error] = e.to_s
  end

end
