class Loanorder < ActiveRecord::Base
	#self.inheritance_column = nil

	#belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'

	#belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id'

  def self.import(file)
      @file = file.path
      #受付日が１年以上前のデータは削除
      #Loanorder.where('reciept_date < ?',1.years.ago.to_date).delete_all()
      CSV.foreach(file.path, headers: true) do |row|
        # 売上NO(row(1)が見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
        if row[0] == '9'
          order = find_by(sales_no: row[1],company_code: row[2],store_code: row[5])
          if order != nil
            order.destroy!
          end
        else
          #row[15] = DateTime.parse(row[15])
          order = find_by(sales_no: row[1],company_code: row[2],store_code: row[5]) || new
          # CSVからデータを取得し、設定する
          order.attributes = row.to_hash.slice(*updatable_attributes)
          # 保存する
          order.save!
        end
      end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["update_flg","sales_no","company_code","company_name","order_date","store_code","store_name","loan_company_name","receipt_number","area","application_money","user_name","old_status","status","charge_date","update_datetime"]
  end
end
