# Be sure to restart your server when you modify this file.

WhatsOnFacebook::Application.config.session_store :cookie_store, key: '_whats_on_facebook_session', :expire_after=>10.years.from_now

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# WhatsOnFacebook::Application.config.session_store :active_record_store
