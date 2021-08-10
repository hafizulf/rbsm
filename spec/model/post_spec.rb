require_relative '../../model/post'

RSpec.describe Post do
    before(:each) do
        @client = double
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
end