class AddUserIdToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :user, index: true, foreign_key: true
  end
end
