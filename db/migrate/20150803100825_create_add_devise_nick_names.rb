class CreateAddDeviseNickNames < ActiveRecord::Migration
  def change
    create_table :add_devise_nick_names do |t|

      t.timestamps null: false
    end
  end
end
