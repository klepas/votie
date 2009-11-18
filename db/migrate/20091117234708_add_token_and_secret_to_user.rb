class AddTokenAndSecretToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :token
      t.string :secret
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :token
      t.remove :secret
    end
  end
end
