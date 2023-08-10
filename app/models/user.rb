class User < ApplicationRecord
  has_many :reviews

  validates :first_name, :last_name, :email, presence: true
end
