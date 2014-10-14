module Api
  class BlobPresenter
    def initialize(path, branch='master')
      @path = path
      @branch = branch
    end

    def as_json(options={})
      blob = REPO.branches[@branch].target.tree # TODO: handle missing branch
      path = @path.split('/')

      path.each do |name|
        oid = (blob.find { |e| e[:name] == name } || {})[:oid]

        unless oid
          # TODO: handle no oid
        end

        blob = REPO.lookup(oid)
      end

      # TODO: handle blob is not a blob

      {
        name: path.last,
        oid: blob.oid,
        type: 'blob',
        href: "#{API_PATH}/blob/#{@branch}/#{@path}",
        content: blob.content,
      }
    end
  end
end
