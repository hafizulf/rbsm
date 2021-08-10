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
end