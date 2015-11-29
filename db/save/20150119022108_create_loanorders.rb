class CreateLoanorders < ActiveRecord::Migration
  def change
    create_table :loanorders do |t|
        t.references :customer, null: false               #顧客レコードへの外部キー
        t.references :staff_member, nll: false            #社員レコードへの外部キー
        t.date :receipt_date, null:false                                    #受付日
        t.string :receipt_number, null:false                            #受付番号
        t.string :family_name, null: false                              #姓（漢字）
        t.string :given_name, null: false                                   #名（漢字）
        t.string :family_name_kana, null: false                     #姓（フリガナ）
        t.string :given_name_kana, null: false                      #名（フリガナ）
        t.date :birthday                                                                    #生年月日
        t.string :gender                                                                    #性別
        t.string :postal_code, null: false                              #郵便番号
        t.string :prefecture, null: false                                   #都道府県
        t.string :city, null: false                                             #市区町村
        t.string :address1, null: false                                     #町域、番地等
        t.string :address2                                                              #建物名、部屋番号等
        t.string :telephone_number                                              #電話番号
        t.string :mobilephone_number                                            #携帯番号
        t.string :email                                                                     #メールアドレス
        t.string :loan_company_name                                             #ローン会社名
        t.string :application_money                                             #申込金額
        t.string :type, null: false                                             #進捗状況
      t.timestamps
    end
    add_index :loanorders, :customer_id
    add_foreign_key :loanorders, :staff_members
    add_foreign_key :loanorders, :customers
  end
end