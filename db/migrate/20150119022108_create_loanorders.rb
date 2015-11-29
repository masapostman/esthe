#業務システムより取り込んだデータを保存する。


class CreateLoanorders < ActiveRecord::Migration
  def change
    create_table :loanorders do |t|
        t.integer :sales_no, null: false                   #売上NO
        t.integer :company_code, null: false               #加盟店コード
        t.string :company_name, null: false                #加盟店名
        t.string :store_code,null: false                   #店舗コード
        t.string :store_name,null: false                   #店舗名
        t.date :order_date, null:false                     #申込日
        t.string :receipt_number                           #受付番号
        t.string :user_name, null: false                   #利用者氏名（漢字）
        t.string :area                                     #本人確認場所
        t.string :loan_company_name, null: false           #ローン会社名
        t.integer :application_money, null: false          #申込金額
        t.string :old_status, null: false                  #旧進捗状況
        t.string :status, null: false                      #進捗状況
        t.date :charge_date                                #入金（立替）日
        t.datetime :update_datetime                        #最終更新日（データ作成日時）
        t.integer :update_flg                              #レコード区分（９：削除、１：新規、更新）
        t.timestamps
    end
  end
end

