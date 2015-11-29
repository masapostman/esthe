class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :company_code            #加盟店コード
      t.string :company_name				 #加盟店名

      t.timestamps
    end
  end
end
