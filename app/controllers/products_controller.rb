class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :new, :edit, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.where("stock > :minimun_stock", {minimun_stock: 0})
    @brands = Brand.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comment = Comment.new
    @comments = Comment.where("comments.product_id = ?", params[:id])
      
  end

  def comment
    comment = Comment.new
    comment.body = params[:comment][:body]
    comment.user_id = current_user.id
    comment.product_id = params[:id]
    @product = Product.find(comment.product_id)

    respond_to do |format|
      if comment.save
        format.html { redirect_to @product , notice: 'Comentario realizado!' }
      end
    end 
  end

  # GET /products/new
  def new
    @product = Product.new
    @memories = Memory.all
    @colors = Color.all
    @models = Model.all
    @storages = Storage.all


  end

  # GET /products/1/edit
  def edit
    @memories = Memory.all
    @colors = Color.all
    @models = Model.all
    @storages = Storage.all
  end

  # POST /products
  # POST /products.json
  def create
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
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:description, :image, :stock, :price, :model_id, :memory_id, :color_id, :storage_id, :video)
    end
end
