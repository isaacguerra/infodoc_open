# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_infodoc_open_session',
  :secret      => 'c8e3740784b0db215078eb8a6f8f9f53cef9fcab4d45b062c4c117b93f76bcda59aba037d2b099286c09eceba8329b9131660fa8e917b4ccfba873eec7a65aa2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
