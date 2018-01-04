require "rubygems"
require "savon"
require "sinatra"
require "pitcher"
require "pitcher/settings"

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'admin' and password == 'admin'
end

get '/' do
  @title = 'CONTENTdm Batch Import'
  erb :index
end

post '/upload' do

  @cfilename = params['csv'][:filename]
  @cfilepath = "./public/uploads/#{@cfilename}"

  @sfilename = params['settings'][:filename]
  @sfilepath = "./public/uploads/#{@sfilename}"


  File.open("./public/uploads/#{@cfilename}", 'w') do |file|
    file.write(params['csv'][:tempfile].read)
  end

  File.open("./public/uploads/#{@sfilename}", 'w') do |file|
    file.write(params['settings'][:tempfile].read)
  end

  pitcher = Pitcher::Pitcher.new

  if (@sfilepath)
    settings = Settings.new(@sfilepath)
    @responsefilename = "response-" + settings.username + ".txt"
    @responsefilepath = "./logs/" + @responsefilename
    File.delete(@responsefilepath) if File.exist?(@responsefilepath)
    p settings
  else
    exit
  end
  
  
  if (@cfilepath)
    csv = pitcher.load_csv(@cfilepath)
    pitcher.create_message(csv,settings)

  else
    exit
  end
  


  

  File.delete(@cfilepath)
  File.delete(@sfilepath)
  
  erb :success

end

get '/success' do
  @title = 'Imported > CONTENTdm Batch Import'
  
  erb :success
end

get '/testconnection' do

  @title = 'Test Connection > CONTENTdm Batch Import'
  erb :testconnection
end

post '/test' do
  cdmurl = params[:cdmurl]
  uname = params[:uname]
  pword = params[:pword]


  client = Savon.client(
      wsdl: "wsdl.xml",
      pretty_print_xml: true,
      log: true
  )

  message = { cdmurl: cdmurl, username: uname, password: pword}

  testresponse = client.call(:get_conten_tdm_http_transfer_version, message: message)

  erb :test, :locals => { message: testresponse }

end

get '/error' do
@title = 'Error > CONTENTdm Batch Import'
end

error do
  erb :error
end