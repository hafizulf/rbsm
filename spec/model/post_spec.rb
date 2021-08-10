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
                msg = "a"*1000
                post = Post.new(message: msg)

                expect(post.message_valid?).to eq(true)
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

                allow(Post).to receive(:new).with(post)

                expect { post.save }.to raise_error(RuntimeError)
            end
        end
    end

    describe "saving post" do
        context "save post and tag" do
            it "should return true" do
                mock = "INSERT INTO posts(message) VALUES ('new post #new') "
                mock2 = "INSERT INTO post_tags(post_id, tag) VALUES ('10', 'new') "

                allow(@client).to receive(:new).and_return(message: 'new post #new')
                expect(@client).to receive(:query).with(mock)

                allow(@client).to receive(:last_id).and_return(10)
                expect(@client).to receive(:query).with(mock2)

                expect(@post.save).to eq(true)
            end
        end
        context "get tag" do
            it "should return a tag in array if exist" do
                allow(@client).to receive(:new).and_return(message: 'new post #new')

                expect(@post.get_tags('new post #new')).to eq(["new"])
            end
        end
    end
end