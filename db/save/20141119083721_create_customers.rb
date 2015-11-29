class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
        t.string :reception_number                                      #受付番号
    	t.integer :company_code            								#会社コード
    	t.string :company_name                                          #会社名（サロン名）
        t.string :top_family_name, null: false                          #代表者名（姓）
        t.string :top_given_name, null: false                           #代表者名（名）
        t.string :top_family_name_kana, null: false                     #フリガナ（姓）
        t.string :top_given_name_kana, null: false                      #フリガナ（名）
        t.string :staff_family_name, null: false                        #担当者名（姓）
        t.string :staff_given_name, null: false                         #担当者名（名）
        t.string :staff_family_name_kana, null: false                   #フリガナ（姓）
        t.string :staff_given_name_kana, null: false                    #フリガナ（名）
        t.string :zip_code,null: false                                  #郵便番号
        t.string :prefecture ,null: false                               #都道府県
        t.string :city,null: false                                      #市区町村
        t.string :address1,null: false                                  #番地等
        t.string :address2                                              #方書等
        t.string :telephone_number                                       #電話番号
        t.string :mobilephone_number                                    #携帯番号
        t.string :fax_number                                            #FAX番号
        t.string :email,null: false										#メールアドレス
    	t.string :email_for_index, null: false							#索引用メールアドレス
        t.string :password_digest                                       #パスワード
        t.date :start_date                                              # 開始日
        t.date :end_date                                                # 終了日
        t.boolean :suspended, null: false, default: false               # 停止フラグ デフォルトはtrueにすべき（まだしてない）
        t.timestamps
    end
    add_index :customers, :email_for_index,unique: true
    add_index :customers, :company_code,unique: true
  end
end
