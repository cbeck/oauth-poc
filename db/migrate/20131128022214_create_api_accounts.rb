class CreateApiAccounts < ActiveRecord::Migration
  def change
    create_table :api_accounts do |t|
      t.string :uid
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret
      t.datetime :oauth_expires

      t.timestamps
    end
  end
end
