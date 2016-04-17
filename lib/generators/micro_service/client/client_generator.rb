require 'rails/generators/base'
require 'micro_service/client/compatibility'

module MicroService
	class Client < ::ActiveRecord::Base
		class Generator < Rails::Generators::Base
			source_paths << File.join(File.dirname(__FILE__), 'templates')
		end
	end
end

