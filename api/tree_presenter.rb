module Api
  class TreePresenter
    def initialize(path, branch='master')
      @path = path
      @branch = branch
    end

    def as_json(options={})
      tree = REPO.branches[@branch].target.tree # TODO: handle missing branch
      path = @path.split('/')

      path.each do |name|
        oid = (tree.find { |e| e[:name] == name } || {})[:oid]

        unless oid
          # TODO: handle no oid
        end

        tree = REPO.lookup(oid)
      end

      # TODO: handle tree is not a tree

      json = {
        href: "#{API_PATH}/tree/#{@branch}/#{@path}".squeeze('/'),
        name: path.last || '/',
        type: 'tree',
        files: [],
      }

      tree.sort_by { |e| [e[:type] == :tree ? 0 : 1, e[:name]] }.each do |e|
        e.delete(:filemode)
        e[:href] = "#{API_PATH}/#{e[:type]}/#{@branch}/#{@path}/#{e[:name]}".squeeze('/')
        json[:files] << e
      end

      json
    end
  end
end
