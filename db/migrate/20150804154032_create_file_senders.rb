class CreateFileSenders < ActiveRecord::Migration
  def change
    create_table :file_senders do |t|
        t.string :file_names
      t.timestamps null: false
    end
  end
end
