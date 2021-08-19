require_relative "../model/post"

class PostController

  def save(params)
    post = Post.new(params)
    post.save
  end

  def post_with_certain_tag(tag)
    Post.find_all_post_with_certain_tag(tag)
  end

  def post_with_most_posted_tag
    Post.find_all_post_with_most_posted_tag
  end

end