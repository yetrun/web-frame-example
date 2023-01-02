# frozen_string_literal: true

module API
  module Applications
    class Doc
      def self.call(env)
        doc = API::Applications::Main.to_swagger_doc(
          info: {
            title: 'Web API 示例项目',
            version: 'current'
          },
          servers: [
            { url: 'http://localhost:9292', description: 'Web API 示例项目' }
          ]
        )
        doc_json = JSON.pretty_generate(doc)
        [200, { 'CONTENT_TYPE' => 'application/json' }, [doc_json]]
      end
    end
  end
end
