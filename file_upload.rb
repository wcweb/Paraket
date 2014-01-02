# encoding: utf-8
require 'uri'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'slim'

class FileUpload < Sinatra::Base
  register Sinatra::Contrib
  configure do
    enable :static
    enable :sessions

    set :views, File.join(File.dirname(__FILE__), 'views')
    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :files, File.join(settings.public_folder, 'files')
    set :unallowed_paths, ['.', '..']
  end

  helpers do
    def flash(message = '')
      session[:flash] = message
    end
  end

  before do
    @flash = session.delete(:flash)
  end

  not_found do
    slim 'h1 404'
  end

  error do
    slim "Error (#{request.env['sinatra.error']})"
  end

  get '/' do
    @files = Dir.entries(settings.files) - settings.unallowed_paths

    slim :index
  end
  
  get '/single' do
    #slim :single
    respond_to do |f|
        # f.xml { nokogiri :single }
        f.on('application/custom') {} # custom_action }
        f.on('text/*') { "sssss"}# data.to_s }
        f.on('*/*') { "matches everything" }
      end
  end
  
  get '/up' do
    @files = Dir.entries(settings.files) - settings.unallowed_paths
    slim :uploadMp3
  end
  
  post '/uploadmp3' do
    # puts params
    if params[:Filedata2]
      filename = params[:Filedata2][:filename]
      file = params[:Filedata2][:tempfile]
      puts filename
      puts file
      File.open(File.join(settings.files, filename), 'wb') do |f|
        f.write file.read
      end
      
      filepath = File.join(settings.files,filename)
      # 
      #puts URI.encode_www_form([["result", URI.encode("File recived ")]])
      
      # "result=filerecived&file=#{filepath}"
      
      respond_with :index, :name=>'example' do |re|
        
        re.txt {URI.encode_www_form([["result", URI.encode("File recived ")],
                            ["file",filepath]])}
      end
      
    else
      flash 'You have to choose a file'
      redirect '/up?'+URI.encode_www_form(["result", URI.encode("error")])
    end

    
  end
  
  post '/upload' do
    if params[:file]
      filename = params[:file][:filename]
      file = params[:file][:tempfile]

      File.open(File.join(settings.files, filename), 'wb') do |f|
        f.write file.read
      end

      flash 'Upload successful'
    else
      flash 'You have to choose a file'
    end

    redirect '/'
  end
end
