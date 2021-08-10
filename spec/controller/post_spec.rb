require_relative "../../controller/PostController"

RSpec.describe PostController do
    before(:each) do
        @controller = PostController.new
    end

    describe "saving post" do
        context "save" do
            it "should call save method" do
                stub = double

                allow(Post).to receive(:new).with([]).and_return(stub)

                expect(stub).to receive(:save)

                @controller.save([])
            end
        end
    end

    describe "get posts" do
        context "when give param for certain tag" do
            it 'should call the method' do
                stub = double
                expect(Post).to receive(:find_all_post_with_certain_tag).and_return(stub)

                @controller.find_posts_with_certain_tag("yabb")
            end
        end
    end
end