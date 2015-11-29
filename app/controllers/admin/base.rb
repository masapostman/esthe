class Admin::Base < ApplicationController

	before_action :authorize
	
	private

	def current_administrator
		if session[:administrator_id]
			@current_staff_member ||=
				Administrator.find_by(id: session[ :administrator_id])
		end
	end

	helper_method :current_administrator



	def authorize
  	unless current_administrator
  		flash.alert = '管理者としてログインしてください。'
  		redirect_to :admin_login
  	end
  end

  def password_gen(length=8)
    numbers = [1,2,3,4,5,6,7,8,9]
    alpha_bigs = ['A','B','C','D','E','F','G','H','J','K','M','N','P','Q','R','S','T','U','V','W','X','Y','Z']
    alpha_smalls = ['a','b','c','d','e','f','g','h','i','j','k','m','n','p','q','r','s','t','u','v','w','x','y','z']
    #特殊文字を入れると利用者の入力ミスが多くなるため、特殊文字を外す
    #symbols = "! # $ % & @ + * ?".split(/\s+/)

    #codes = [numbers, alpha_bigs, alpha_smalls, symbols].shuffle
    codes = [numbers, alpha_bigs, alpha_smalls].shuffle
    password = []

    length.times do |i|
      password << codes[i % codes.length].sample(1)
    end

    password.shuffle.join

  end

	
end