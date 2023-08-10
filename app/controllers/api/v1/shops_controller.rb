class Api::V1::ShopsController < ActionController::API
  before_action :shop_params, only: [:create]
  before_action :set_shop, only: [:show]

  def show
  end

  def index
    @shops = Shop.all
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :street, :zipcode, :city, :neighbourhood, :popup)
  end

  def render_error
    render json: { errors: @shop.errors.full_messages },
                 status: :unprocessable_entity
  end
end
