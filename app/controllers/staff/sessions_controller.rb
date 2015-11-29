class Staff::SessionsController < Staff::Base

	skip_before_action :authorize

	def new 
		if current_staff_member
			redirect_to :staff_root
		else
			@login_form = Staff::LoginForm.new
			render action: 'new'
		end
	end

	def create
    @login_form = Staff::LoginForm.new(params[:staff_login_form])
    if @login_form.valid?
	    if @login_form.email.present?
	      staff_member = StaffMember.find_by(email_for_index: @login_form.email.downcase)
	    end
	    if Staff::Authenticator.new(staff_member).authenticate(@login_form.password)
	    	if staff_member.suspended?
	    		staff_member.events.create!(type: 'rejected')
	    		flash.now.alert = 'アカウントが停止されています。'
	    		render action: 'new'
	    	else
	        session[:staff_member_id] = staff_member.id
	        session[:last_access_time] = Time.current
	        #2015-11-27 インポートログに出力するために追加（以下の１行）
	        session[:email] = staff_member.email_for_index
	        staff_member.events.create!(type: 'logged_in')
	        flash.notice = 'ログインしました。'
	        redirect_to :staff_root
	      end
	    else
	      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
	      render action: 'new'
	    end
	  else
	   	render action: 'new'
	   	#render text: @form.errors.full_messages[0]
	  end
  end
  def destroy
  	if current_staff_member
  		 current_staff_member.events.create!(type: 'logged_out')
  	end
  	session.delete(:staff_member_id)
  	flash.notice = 'ログアウトしました。'
  	redirect_to :staff_root
  end
end
