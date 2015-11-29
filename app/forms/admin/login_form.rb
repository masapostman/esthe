class Admin::LoginForm
  include ActiveModel::Model
 
  attr_accessor :email, :password

  validates :email, :password,presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX , allow_blank: true}
  validates :password, length: { minimum: 6, allow_blank: true, 
  	message: 'は６文字以上で入力してください。'}
end
