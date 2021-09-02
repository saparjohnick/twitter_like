module QueryObjects
  class SearchMicropostQuery < BaseQuery

    def default_relation
      Micropost
    end

    def call(pattern = key_string || '')
      relation.where('lower(content) LIKE ?', "%#{pattern}%").as_json
    end
  end
end
