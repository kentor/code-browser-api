require './api'
require 'json'
require 'sinatra'
require 'sinatra/json'

get '/' do
  'OK'
end

get '/api/?' do
  call env.merge('PATH_INFO' => '/api/tree/master')
end

get '/api/blob/:branch/*' do
  headers 'Access-Control-Allow-Origin' => '*'

  path = params[:splat].first
  branch = params[:branch]

  json Api::BlobPresenter.new(path, branch).as_json
end

get '/api/tree/:branch/?*' do
  headers 'Access-Control-Allow-Origin' => '*'

  path = params[:splat].first
  branch = params[:branch]

  json Api::TreePresenter.new(path, branch).as_json
end
