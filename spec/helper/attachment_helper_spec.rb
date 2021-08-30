# frozen_string_literal: true

require './helper/attachment_helper'
require 'rack'

RSpec.describe AttachmentHelper do
  before(:each) do
    @attachment = AttachmentHelper.new
  end

  context 'when file is nil' do
    it "should return '' " do
      actual = @attachment.get_file(nil, 'posts')
      expect(actual).to eq('')
    end
  end

  context 'file validation failed' do
    it 'raises' do
      file_mock =  double

      attachment = {
        filename: 'video.mkv',
        tempfile: file_mock
      }

      allow(@attachment).to receive(:get_mime).with(file_mock).and_return('video/mkv')

      expect { @attachment.get_file(attachment, 'posts') }.to raise_error(RuntimeError)
    end
  end

  context 'when file validated' do
    it 'should return a filename' do
      file_mock =  double

      attachment = {
        filename: 'file_name.png',
        tempfile: file_mock
      }

      allow(@attachment).to receive(:validate_file?).and_return(true)
      allow(@attachment).to receive(:upload_file)

      allow(SecureRandom).to receive(:urlsafe_base64).and_return('')

      file_name = attachment[:filename]
      expected = ".#{file_name}"
      actual = @attachment.get_file(attachment, 'posts')

      expect(actual).to eq(expected)
    end

    it 'validate_file? == true' do
      file_mock = double

      allow(@attachment).to receive(:get_mime).with(file_mock).and_return('image/png')

      expect(@attachment.validate_file?(file_mock)).to eq(true)
    end
  end

  context 'get mime type' do
    it 'should return a mime' do
      expected = 'image/png'
      actual = @attachment.get_mime('file_name.png')
      expect(actual).to eq(expected)
    end
  end

  context 'store file' do
    it 'store file in posts folder' do
      file_mock =  double
      f_mock = double
      file_read = double

      loc = './public/uploads/posts/file_name.png'

      expect(File).to receive(:open).with(loc, 'wb').and_yield(f_mock)
      allow(file_mock).to receive(:read).and_return(file_read)
      allow(f_mock).to receive(:write).with(file_read)

      @attachment.upload_file(file_mock, 'file_name.png', 'posts')
    end
    it 'store file in comments folder' do
      file_mock =  double
      f_mock = double
      file_read = double

      loc = './public/uploads/comments/file_name.png'

      expect(File).to receive(:open).with(loc, 'wb').and_yield(f_mock)
      allow(file_mock).to receive(:read).and_return(file_read)
      allow(f_mock).to receive(:write).with(file_read)

      @attachment.upload_file(file_mock, 'file_name.png', 'comments')
    end
  end
end
