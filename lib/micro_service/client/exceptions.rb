require "active_record"

module MicroService
	class Client < ::ActiveRecord::Base
		# Raise if failed contact client server about installation
		class InstallError < StandardError; end
	end
end
	