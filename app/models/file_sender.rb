class FileSender < ActiveRecord::Base
    mount_uploader :file_names, FileUploaderUploader
end