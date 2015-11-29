class Customer::LoanorderSearchForm
	include ActiveModel::Model

	require 'date'

	attr_accessor :order_date_from, :order_date_to,:company_code,:store_code,:store_name,:company_id

	validates :order_date_to, date: {after: :order_date_from,allow_blank: true}

	validate :start_end_check

	def search(company_code,store_no,cls)
		rel = Loanorder.joins('INNER JOIN customers ON loanorders.store_code = customers.store_code
										 AND loanorders.company_code = customers.company_id')
									 .select('loanorders.sales_no,loanorders.company_code,loanorders.company_name,
									 	loanorders.store_code,customers.store_name,loanorders.order_date,loanorders.receipt_number,
									 	loanorders.user_name,loanorders.area,loanorders.loan_company_name,loanorders.application_money,
									 	loanorders.area,loanorders.old_status,loanorders.status,loanorders.charge_date')
		#loginした加盟店コードで絞る
		rel = rel.where(company_code: company_code)
		#loginしたユーザｉｄ(Email)が個店である場合は、個店の情報しか見せない
		if cls == '1' then
			if store_code.present?
				if store_code == "" 
				else
					rel = rel.where(store_code: format("%02d",store_code))
				end
			end
		else
			#店舗での絞り込みを漏れしていた 2015/10/24対応
			#2015/10/27 format関数追加
			rel = rel.where(store_code: format("%02d",store_no))

		end
		#申込日の範囲指定によるデータの絞り込み
		if order_date_from.present? && order_date_to.present?
			 date_from = Date.parse(order_date_from)
			 date_to = Date.parse(order_date_to)
			 date_to = date_to + 1.days
			 rel = rel.where(order_date: date_from...date_to)
		else
			if order_date_from.present? 
				 date_from = Date.parse(order_date_from)
				 rel = rel.where('order_date >= ?',date_from)
			else
				if order_date_to.present?
					 date_to = Date.parse(order_date_to)
					 rel = rel.where('order_date <= ?',date_to)
				end
			end
		end
		  	rel.order("order_date desc")
	end

	private

	def start_end_check
		errors.add(:self.order_date_to,"は開始日付以降の日付を指定してください。") unless
		self.Date.parse.order_date_to  < self.Date.parse.order_date_from
	end
end