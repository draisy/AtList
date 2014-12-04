Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_id'], ENV['facebook_secret'],
  :scope => 'user_friends,email,public_profile', :auth_type => 'reauthenticate'
end