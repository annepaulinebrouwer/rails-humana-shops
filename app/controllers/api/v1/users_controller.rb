class Api::V1::UsersController < ActionController::API
  before_action :set_user, only: [:show]

  def show
  end

  def create
    json = get_github_user_info
    @user = User.new(
      first_name: json["name"],
      last_name: json["location"],
      email: "#{json["login"]}@email.com"
    )

    if @user.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def get_github_user_info
    url = "https://api.github.com/users/#{params["users"]["username"]}"
    response = URI.open(url).read
    JSON.parse(response)
  end

  def render_error
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
end
