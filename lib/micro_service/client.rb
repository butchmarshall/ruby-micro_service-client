require "active_support"
require "active_support/dependencies"
require "active_record"

require "micro_service/client/version"
require "micro_service/client/compatibility"
require "micro_service/client/configuration"
require "micro_service/client/class_methods"
require "micro_service/client/instance_methods"

require "micro_service/client/exceptions"

module MicroService
	class Client < ::ActiveRecord::Base
	end
end

MicroService::Client.send :include, MicroService::Client::InstanceMethods
MicroService::Client.send :extend, MicroService::Client::ClassMethods