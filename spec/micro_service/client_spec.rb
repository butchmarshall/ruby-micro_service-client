require 'spec_helper'

describe MicroService::Client do
	it 'has a version number' do
		expect(MicroService::Client::VERSION).not_to be nil
	end

	describe '#create' do
		before(:each) do
			@secret = "K0Cnt7Itd1LlOPtbS5Tj6I6zqkSRcOUJ.s"
			@stub = stub_request(:post, "https://client-server.local/install-here")
		end

		it 'should inform client server of installation' do
			MicroService::Client.configure do |config|
				config.url = "https://microservice-server-working.local"
			end

			@stub.to_return(:status => 200, :body => "", :headers => {})
				.with(:body => "{\"client_id\":1,\"secret\":\"#{@secret}\",\"url\":\"https://microservice-server-working.local\",\"timestamp\":#{Time.now.to_i}}", :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'})

			@micro_service_client = MicroService::Client.new({
				secret: @secret,
				install_url: "https://client-server.local/install-here",
				uninstall_url: "https://client-server.local/uninstall-here"
			})

			@micro_service_client.save
		end

		it 'should raise MicroService::Client::InstallError if unable to contact client server' do
			MicroService::Client.configure do |config|
				config.url = "https://microservice-server-broken.local"
			end

			@stub.to_return(:status => 404, :body => "", :headers => {})
				.with(:body => "{\"client_id\":1,\"secret\":\"#{@secret}\",\"url\":\"https://microservice-server-broken.local\",\"timestamp\":#{Time.now.to_i}}", :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'})

			@micro_service_client = MicroService::Client.new({
				secret: @secret,
				install_url: "https://client-server.local/install-here",
				uninstall_url: "https://client-server.local/uninstall-here"
			})

			expect { @micro_service_client.save }.to raise_error ::MicroService::Client::InstallError
		end
	end
end
