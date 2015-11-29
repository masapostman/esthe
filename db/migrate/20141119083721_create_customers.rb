class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
    #	t.integer :company_code , nulll: false							#加盟店コード
    #	t.string :company_name, null: false                             #加盟店名
        t.references :company,null: false                               #外部参照キー（加盟店コード）
        #t.integer :company_name, null:false                             #加盟店名
        t.integer :store_code, null:false                               #店舗コード
        t.string :store_name, null: false                               #店舗名（サロン名）
        t.string :staff_family_name, null: false                        #担当者名（姓）
        t.string :staff_given_name, null: false                         #担当者名（名）
        t.string :staff_family_name_kana, null: false                   #フリガナ（姓）
        t.string :staff_given_name_kana, null: false                    #フリガナ（名）
        t.string :postal_code                                           #郵便番号(項目のみ準備：使用しないかも)
        t.string :prefecture                                            #都道府県(項目のみ準備：使用しないかも)
        t.string :city                                                  #市区町村(項目のみ準備：使用しないかも)
        t.string :address1                                              #番地等(項目のみ準備：使用しないかも)
        t.string :address2                                              #方書等(項目のみ準備：使用しないかも)
        t.string :telephone_number                                      #電話番号
        t.string :email,null: false										#メールアドレス
    	t.string :email_for_index, null: false							#索引用メールアドレス
        t.string :init_password                                         #初期パスワード（自動生成）
        t.string :password_digest                                       #パスワード
        t.date :start_date                                              # 開始日
        t.date :end_date                                                # 終了日
        t.boolean :suspended, null: false, default: false               # 停止フラグ
        t.string :parent_and_child, null: false, default: '子'          # 親子区分    
        t.timestamps
    end
    add_index :customers, :email_for_index,unique: true
    add_index :customers, :company_id
    add_index :customers, [:company_id,:store_code],unique: true
    #add_index :customers, [:company_code, :store_code], unique: true
  end
end
