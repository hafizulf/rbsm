require_relative '../../model/comment'

RSpec.describe Comment do
    before(:each) do
        @client = double
        @comment = Comment.new(id: 10, post_id: 22, comment: "new comment #new")
        allow(Mysql2::Client).to receive(:new).and_return(@client)
    end

    describe "save comment" do
        context "saving comment" do
            it "should return ok" do
                mock = "INSERT INTO comments(post_id, comment) VALUES('22', 'new comment #new') "

                allow(@client).to receive(:new).and_return(post_id: 22, comment: 'new post #new')
                expect(@client).to receive(:query).with(mock)

                expect(@comment.save).to eq(true)
            end
        end
    end

end