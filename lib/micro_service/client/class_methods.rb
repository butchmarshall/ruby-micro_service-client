require "validate_url"

module MicroService	
	class Client < ::ActiveRecord::Base
		module ClassMethods
			def self.extended(base)
				base.send(:attr_accessor, :configuration)
				base.validates :secret, :presence => true
				base.validates :install_url, :presence => true, url: true
				base.after_initialize :initialize_secret
				base.after_create :after_create_notify_client_service
			end

			def configuration
				@configuration
			end

			def configure
				@configuration ||= MicroService::Client::Configuration.new
				yield(@configuration)
			end
		end
	end
end