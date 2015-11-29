class CreateImportLogs < ActiveRecord::Migration
  def change
    create_table :import_logs do |t|
      t.string :email
      t.datetime :import_datetime
      t.string :import_filename

      t.timestamps
    end
  end
end
