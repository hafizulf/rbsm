class AttachmentHelper
    def get_file(file)
        if file.nil?
            return ''
        else
            file_name = file[:filename]
            file = file[:tempfile]

            return false unless validate_file(file_name)

            mime = get_mime(file)

            upload_file(file, file_name, mime)
        end
    end

    def validate_file(file)
        raise "File Not allowed" if check_mime(file) == false
        true
    end

    def check_mime(file)
        mime_types = ['image/gif', 'image/jpg', 'image/png', 'video/mp4', 'application/pdf', 'application/msword', 'application/vnd.ms-excel']

        mime = get_mime(file)

        return false unless mime_types.include?(mime)
        true
    end

    def get_mime(file)
        ext = File.extname(file)
        mime = Rack::Mime.mime_type(ext)
    end

    def upload_file(file, file_name, mime)
        filename = "#{SecureRandom.urlsafe_base64}#{file_name}"
        type = mime.split('/').first

        case type
        when 'image' || 'video'
            File.open("./public/uploads/#{type}s/#{filename}", 'wb') do |f|
                f.write(file.read)
            end
        else
            File.open("./public/uploads/files/#{filename}", 'wb') do |f|
                f.write(file.read)
            end
        end

        return filename
    end
end