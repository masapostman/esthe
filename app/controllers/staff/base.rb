class Staff::Base < ApplicationController
	before_action :authorize
	before_action :check_account
	before_action :check_timeout

	private

	def current_staff_member
		if session[:staff_member_id]
			@current_staff_member ||=
				StaffMember.find_by(id: session[ :staff_member_id])
		end
	end

	helper_method :current_staff_member

	def authorize
  	unless current_staff_member
  		flash.alert = 'システム担当者としてログインしてください。'
  		redirect_to :staff_login
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

  def check_account
  	if current_staff_member && !current_staff_member.active?
  		session.delete(:staff_member_id)
  		flash.alert = 'アカウントが無効になりました。'
  		redirect_to :staff_root
  	end
  end

  TIMEOUT = 60.minutes

  def check_timeout
  	if current_staff_member
  		if session[:last_access_time] >= TIMEOUT.ago
  			session[:last_access_time] = Time.current
  		else
  			session.delete(:staff_member_id)
  			flash.alert = 'セッションがタイムアウトしました。'
  			redirect_to :staff_login
  		end
  	end

  end


	
end