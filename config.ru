#app = proc do |env|
#    message = "It works!\n"
#    version = "Ruby %s\n" % RUBY_VERSION
#    response = [message, version].join("\n")
#    [200, {"Content-Type" => "text/plain"}, [response]]
#end


#run app

require './app'

#require 'logger'
#set :root, File.dirname(__FILE__)
#log_file = File.new(File.join(settings.root, 'log', "#{settings.environment}.log"), 'a+')
#log_file.sync = true
#use Rack::CommonLogger, log_file



require 'logger'
#Logger.class_eval { alias :write :'<<' }
#logger = ::Logger.new(::File.new("log/app.log","a+")
#use Rack::CommonLogger, logger


  ::Logger.class_eval { alias :write :'<<' }
  access_log = ::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','access.log')
  access_logger = ::Logger.new(access_log)
  error_logger = ::File.new(::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','error.log'),"a+")
  error_logger.sync = true
 
  configure do
    use ::Rack::CommonLogger, access_logger
  end
 
  before {
    env["rack.errors"] =  error_logger
  }

run Sinatra::Application
