module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      def create_category(args)
        args = API.params(args)
                  .required(:name, :color, :text_color)
                  .optional(:description)
                  .default(parent_category_id: nil)
        response = post("/categories", args)
        response['category']
      end

      def categories(params={})
        response = get('/categories.json', params)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(category_slug)
        response = get("/category/#{category_slug}/l/latest.json")
        response[:body]['topic_list']['topics']
      end

      def category_top_topics(category_slug)
        response = get("/category/#{category_slug}/l/top.json")
        response[:body]['topic_list']['topics']
      end

      def category_new_topics(category_slug)
        response = get("/category/#{category_slug}/l/new.json")
        response[:body]['topic_list']['topics']
      end

      def category(id)
        response = get("/c/#{id}/show")
        response.body['category']
      end

      def set_permission(category_name, group_id, permission_type)
        # permission_type should be an integer
        # 1 = Full
        # 2 = Create Post
        # 3 = Read Only
        put("/categories/#{category_id}", { name: category_name, :permissions => {group_id => permission_type} })
      end
    end
  end
end
