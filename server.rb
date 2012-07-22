require "./gem_requires"
require "./models/db"
Dir.new("#{File.dirname(__FILE__)}/lib").each { |lib| require "./lib/#{lib}" if File.extname(lib) == '.rb' }
Dir.new("#{File.dirname(__FILE__)}/routes").each { |lib| require "./routes/#{lib}" if File.extname(lib) == '.rb' }
disable :show_exceptions
disable :raise_errors

helpers CommonModule::CommonHelper

error do
  {status: "error", payload: env['sinatra.error'].message }.to_json
end

not_found do
  {status: "error", payload: "API not found"}.to_json
end

# only for HTTP POST calls (create or update) will we check for API key validity
before request_method: :post do
  raise "No API key provided or wrong API key provided" if User.first(api_key: params[:api_key]).nil?
end

# log everything
after do
  log = Log.new
  log.remote_addr = request.env['REMOTE_ADDR']
  log.client = request.env['HTTP_USER_AGENT']
  log.method = request.env['REQUEST_METHOD']
  log.path = request.env['REQUEST_PATH']
  log.http_version = request.env['HTTP_VERSION']
  log.return_code = response.status.to_s
  log.return_size = response.body.to_s.gsub("\\","").size
  if params[:api_key]
    user = User.first api_key: params[:api_key]
    log.user_uuid = user.uuid
  end
  log.save
end

# index page
get "/" do
  haml :index
end
