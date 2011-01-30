class RemoveTwitterAuthAddAuthlogic < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      # Remove twitter auth fields
      t.remove :token, :secret

      # Add fields for Authlogic
      t.string    :login,               :null => false, :default => '' # optional, you can use email instead, or both
      t.string    :crypted_password,    :null => false, :default => '' # optional, see below
      t.string    :password_salt,       :null => false, :default => '' # optional, but highly recommended
      t.string    :persistence_token,   :null => false, :default => '' # required
      t.string    :single_access_token, :null => false, :default => '' # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false, :default => '' # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0  # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0  # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                     # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                       # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                    # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                       # optional, see Authlogic::Session::MagicColumns
    end
  end

  def self.down
    change_table :users do |t|
      # Add twitter auth fields
      t.string :token, :secret

      # Remove Authlogic fields
      t.remove :login
      t.remove :crypted_password
      t.remove :password_salt
      t.remove :persistence_token
      t.remove :single_access_token
      t.remove :perishable_token

      t.remove :login_count
      t.remove :failed_login_count
      t.remove :last_request_at
      t.remove :current_login_at
      t.remove :last_login_at
      t.remove :current_login_ip
      t.remove :last_login_ip
    end
  end
end
