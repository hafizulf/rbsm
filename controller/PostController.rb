require_relative "../model/post"

class PostController

    def save(params)
        post = Post.new(params)
        post.save
    end

    def find_posts_with_certain_tag(tag)
        Post.find_all_post_with_certain_tag(tag)
    end
end