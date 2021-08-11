require_relative '../../controller/CommentController'

RSpec.describe CommentController do
    describe "save comment" do
        it "should call save method" do
            stub = double

            allow(Comment).to receive(:new).with([]).and_return(stub)

            expect(stub).to receive(:save)

            controller = CommentController.new
            controller.save_comment([])
        end
    end
end