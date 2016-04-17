module MicroService
	class Client < ::ActiveRecord::Base
		module InstanceMethods
			def self.included(base)
				base.table_name = "micro_service_clients"
			end

			private
				def initialize_secret
					require 'securerandom'
					self.secret ||= "#{SecureRandom.base64(24)}.s"
				end

				# Notifies the client service the install was successful
				def after_create_notify_client_service
					require "open-uri"
					require "net/http"
					require "openssl"

					uri = URI.parse(self.install_url)
					http = Net::HTTP.new(uri.host, uri.port)
					http.use_ssl = true if uri.scheme == "https"

					request = Net::HTTP::Post.new(uri.request_uri)
					request["Content-Type"] = "application/json"
					request.body = {
						client_id: self.id,
						secret: self.secret,
						url: ((MicroService::Client.configuration)? MicroService::Client.configuration.url : ""),
						timestamp: self.created_at.to_i,
					}.to_json

					response = http.request(request)

					# Failed to register with external service
					if !response.kind_of? Net::HTTPSuccess
						raise ::MicroService::Client::InstallError
					end
				end
		end
	end
end