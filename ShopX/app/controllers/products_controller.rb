class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.select("brand_id,br.sName, products.Price, products.Description, products.id, products.Name").joins("LEFT JOIN brands br ON br.id = products.brand_id ");
    @brands = Brand.all
    @sum = Product.sum("Price")
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @brands = Brand.all
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @brands = Brand.all
  end

  # POST /products
  # POST /products.json
  def create
    @brands = Brand.all
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @brands = Brand.all
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @brands = Brand.all
      @sum = Product.sum("Price")
      @product = Product.select("brand_id,br.sName, products.Price, products.Description, products.id, products.Name").joins("LEFT JOIN brands br ON br.id = products.brand_id ").find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:Name, :Description, :Price, :brand_id)
    end
end