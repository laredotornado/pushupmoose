# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Logger.new(STDOUT)

#ENV['SSL_CERT_FILE'] = /opt/certs/cacert.pem
