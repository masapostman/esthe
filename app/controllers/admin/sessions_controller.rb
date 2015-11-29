class Admin::SessionsController < Admin::Base

	skip_before_action :authorize

	def new 
		if current_administrator
			redirect_to :admin_root
		else
			@login_form = Admin::LoginForm.new
			render action: 'new'
		end
	end

	def create
    @login_form = Admin::LoginForm.new(params[:admin_login_form])
    if @login_form.valid?
	    if @login_form.email.present?
	      administrator = Administrator.find_by(email_for_index: @login_form.email.downcase)
	    end
	    if Admin::Authenticator.new(administrator).authenticate(@login_form.password)
	    	if administrator.suspended?
	    		flash.now.alert = 'アカウントが停止されています。'
	    		render action: 'new'
	    	else
	        session[:administrator_id] = administrator.id
	        #2015-11-27 インポートログに出力するために追加（以下の１行）
	        session[:email] = administrator.email_for_index
	        flash.notice = 'ログインしました。'
	        redirect_to :admin_root
	      end
	    else
	      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
	      render action: 'new'
	    end
	   else
	   	render action: 'new'
	   end
  end
  def destroy
  	session.delete(:administrator_id)
  	flash.notice = 'ログアウトしました。'
  	redirect_to :admin_root
  end
end

