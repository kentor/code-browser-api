require 'rugged'

module Api
  API_PATH = '/api'
  REPO = Rugged::Repository.new(ENV['REPO'] || '.')
end

require './api/blob_presenter'
require './api/tree_presenter'
