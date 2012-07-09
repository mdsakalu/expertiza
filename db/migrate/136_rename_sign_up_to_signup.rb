class RenameSignUpToSignup < ActiveRecord::Migration
  def self.up
    rename_table :sign_up_topics, :signup_topics
    rename_index :signup_topics, :fk_sign_up_categories_sign_up_topics, :fk_signup_categories_signup_topics

    rename_index :signed_up_users, :fk_signed_up_users_sign_up_topics, :fk_signed_up_users_signup_topics
  end

  def self.down
    rename_table :signup_topics, :sign_up_topics
    rename_index :sign_up_topics, :fk_signup_categories_signup_topics, :fk_sign_up_categories_sign_up_topics

    rename_index :signed_up_users, :fk_signed_up_users_signup_topics, :fk_signed_up_users_sign_up_topics
  end
end
