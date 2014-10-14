require './api'
require 'json'
require 'sinatra'
require 'sinatra/json'
require 'byebug' rescue LoadError

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET']
end

get '/' do
  'OK'
end

get '/api/?' do
  call env.merge('PATH_INFO' => '/api/tree/master')
end

get '/api/blob/:branch/*' do
  path = params[:splat].first
  branch = params[:branch]

  json Api::BlobPresenter.new(path, branch).as_json
end

get '/api/tree/:branch/?*' do
  path = params[:splat].first
  branch = params[:branch]

  json Api::TreePresenter.new(path, branch).as_json
end

options '/*' do
  200
end
