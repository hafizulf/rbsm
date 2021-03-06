# frozen_string_literal: true

require_relative '../../model/comment'

RSpec.describe Comment do
  before(:each) do
    @client = double
    @comment = Comment.new(id: 10, post_id: 22, comment: 'new comment #new')
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end

  context 'saving comment' do
    it 'should return true' do
      mock = "INSERT INTO comments(post_id, comment, attachment) VALUES('22', 'new comment #new', '') "
      mock2 = "INSERT INTO tags(post_id, tag) VALUES('22', 'new') "

      allow(@client).to receive(:new).and_return(post_id: 22, comment: 'new post #new')
      allow(@comment).to receive(:check_post_id).and_return(1)
      expect(@client).to receive(:query).with(mock)

      allow(@client).to receive(:last_id).and_return(22)
      expect(@client).to receive(:query).with(mock2)

      expect(@comment.save).to eq('Successfully commented')
    end
  end

  context 'get post_id' do
    it 'should return data size' do
      mock = "SELECT id FROM posts WHERE id = '22' "
      stub = [{ id: 22 }]

      expect(@client).to receive(:query).with(mock).and_return(stub)

      model = @comment.check_post_id

      expect(model).to eq(1)
    end
    it 'raises' do
      mock = "SELECT id FROM posts WHERE id = '22' "
      stub = []

      expect(@client).to receive(:query).with(mock).and_return(stub)

      expect { @comment.save }.to raise_error(RuntimeError)
    end
  end

  describe 'passed param validation' do
    context 'params not nil' do
      it 'should return true' do
        expect(@comment.valid?).to eq(true)
      end
    end

    context 'comment below 1000 chars' do
      it 'should return true' do
        expect(@comment.comment_valid?).to eq(true)
      end
    end
  end

  describe 'failed to pass param validation' do
    context 'params nil' do
      it 'should return false' do
        model = Comment.new(post_id: 22)
        expect(model.save).to eq(false)
      end
    end

    context 'comment more than 1000 chars' do
      it 'should return false' do
        comment = 'a' * 1009
        model = Comment.new(comment: comment)
        expect(model.comment_valid?).to eq(false)
      end
    end

    context 'when comment_valid? called' do
      it 'should raise a runtime error' do
        msg = 'a' * 1001
        comment = Comment.new(post_id: 22, comment: msg)

        expect { comment.save }.to raise_error(RuntimeError)
      end
    end
  end
end
