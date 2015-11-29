class Staff::ImportLogsController <  Staff::Base
		def index
		@logs = ImportLog.all
		@logs = @logs.order(import_datetime: :desc).page(params[:page]).per(30)
	end
end
