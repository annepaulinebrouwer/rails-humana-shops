class Api::V1::ShopsController < ActionController::API

  def index
    @shops = Shop.all
  end
end
