# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_blockhead_session',
  :secret      => '342801d2d33c06383d1c7817cc865322dd16a72be126662d705f5fe8237b12103717f631efd6391e92b68e157cfb4d6c60051189d43ee3ee948a9478183d6b20'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
