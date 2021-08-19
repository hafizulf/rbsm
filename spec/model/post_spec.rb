require_relative '../../model/post'

RSpec.describe Post do

  before(:each) do
    @client = double
    @post = Post.new(id: 10, message: "new post #new")
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end

  describe "post validation" do
    context "when length of message meets requirement" do
      it "should return true" do
        expect(@post.message_valid?).to eq(true)
      end
    end

    context "when out of max length of message" do
      it "should return false" do
        msg = "a"*1001
        post = Post.new(message: msg)
        expect(post.message_valid?).to eq(false)
      end
    end

    context "when message_valid? called" do
      it "should raise a runtime error" do
        msg = "a"*1001
        post = Post.new(message: msg)
        expect { post.save }.to raise_error(RuntimeError)
      end
    end

    context "when message is nil" do
      it "should return false" do
        model = Post.new({})
        expect(model.message_valid?).to eq(false)
      end
    end

    context "when message not nil" do
      it "should return true" do
        expect(@post.message_valid?).to eq(true)
      end
    end
  end

  describe "saving post" do
    context "save post and tag" do
      it "should return success message" do
        mock = "INSERT INTO posts(message, attachment) VALUES ('new post #new', '') "
        mock2 = "INSERT INTO tags(post_id, tag) VALUES ('10', 'new') "

        allow(@client).to receive(:new).and_return(message: 'new post #new')
        expect(@client).to receive(:query).with(mock)

        allow(@client).to receive(:last_id).and_return(10)
        expect(@client).to receive(:query).with(mock2)

        expect(@post.save).to eq("Post created successfully")
      end
    end

    context "get tag" do
      it "should return a tag in array if exist" do
        expect(@post.get_tags('new post #new')).to eq(["new"])
      end
    end
  end

  describe "get posts" do
    context "when give param for certain tag" do
      it 'should return all related data' do
        mock = "SELECT id, message, tag FROM posts LEFT JOIN tags ON posts.id = tags.post_id WHERE tag = 'new' "
        stub = [{
            id: 10,
            message: "new post #new",
            tag: "new"
        }]

        expect(@client).to receive(:query).with(mock).and_return(stub)

        post = Post.find_all_post_with_certain_tag('new')
        expect(post).to be_an Enumerator
      end
    end
  end

  describe "get trending hashtag" do
    it "return 5 most posted tag" do
      mock = "SELECT tag, COUNT(tag) AS `Total Posted` FROM tags LEFT JOIN posts ON tags.post_id = posts.id LEFT JOIN comments ON comments.post_id = posts.id WHERE created_at >= NOW() - INTERVAL 1 DAY GROUP BY tag ORDER BY `Total Posted` DESC LIMIT 5"
      stub = []

      expect(@client).to receive(:query).with(mock).and_return(stub)

      post = Post.find_all_post_with_most_posted_tag
      expect(post).to be_an Enumerator
    end
  end

end