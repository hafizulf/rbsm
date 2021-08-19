require 'webrick/httputils'
require 'securerandom'

class AttachmentHelper

  def get_file(file, type)
      return '' if file.nil?

      file_name = file[:filename]
      file = file[:tempfile]

      raise "File Not allowed" unless validate_file?(file)

      filename = generate_filename(file_name)

      upload_file(file, filename, type)

      return filename
  end

  def generate_filename(filename)
      "#{SecureRandom.urlsafe_base64}.#{filename}"
  end

  def validate_file?(file)
    mime_types = ['image/gif', 'image/jpg', 'image/png', 'video/mp4', 'application/pdf', 'application/msword', 'application/vnd.ms-excel']

    mime = get_mime(file)

    return false unless mime_types.include?(mime)
    true
  end

  def get_mime(file)
    ext = File.extname(file)
    Rack::Mime.mime_type(ext)
  end

  def upload_file(file, filename, type)
      if type == "posts"
          File.open("./public/uploads/posts/#{filename}", 'wb') do |f|
              f.write(file.read)
          end
      else
          File.open("./public/uploads/comments/#{filename}", 'wb') do |f|
              f.write(file.read)
          end
      end
  end

end