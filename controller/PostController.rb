require_relative "../model/post"

class PostController

    def save(params)
        msg = params['message']
        tags = get_tags(msg)

        post = Post.new({
            message: msg,
            tags: tags
        })

        post.save
    end

    def get_tags(param)
        param = param.downcase
        msg = param.split(' ')
        arr = msg.select { |word| word.start_with?('#') }.uniq
        if arr.size > 0
            arr.each {|a| a[0] = ''}
            return arr.join(", ")
        else
            return ''
        end
    end
end