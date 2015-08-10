#
# This class will wrap an S3 object and provide the methods that the Mailgun library expects in order
# to use the S3 object for sending a mail attachment.
#
# Use as follows:
#
# data = Multimap.new
# data[:from] = "My Self <no-reply@example.com>"
# data[:subject] = "Subject"
# data[:to] = "#{recipients.join(', ')}"
# data[:text] = text_version_of_your_email
# data[:html] = html_version_of_your_email
# data[:attachment] = MailgunS3Attachment.new(file_name, file_key)
# RestClient.post "https://api:#{API_KEY}"\
#   "@api.mailgun.net/v2/#{MAILGUN_DOMAIN}/messages",
#   data
#
# Note that some environment variables are expected to be set; you can change these to config vars in your
# app if you want to, of course. See #initialize for those.
#
# One other note: This unfortunately has to read in the complete file in order to be able to hand out chunks
# of the S3 object. If your attachments are really big, this could be a Bad Thing so be aware of it.
#
class MailgunS3Attachment

  # file_name: the name that you want the attachment to have when the recipient receives the email
  # file_key: the S3 object in your bucket
  def initialize(file_name, file_key)
    @file_name = file_name
    @file_key = file_key
    @contents = nil
    @offset = 0
    s3 = AWS::S3.new(access_key_id: ENV['AKIAJOJC5CTYELAWPZBQ'], secret_access_key: ENV['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'])
    b = s3.buckets[ENV['bucket-dev-teemaero']]
    @s3_file = b.objects[file_key]
    #s3 = Aws::S3::Client.new(region:'ap-northeast-1', access_key_id: ENV['AKIAJOJC5CTYELAWPZBQ'], secret_access_key: ENV['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'])
    #resp = s3.list_buckets(ENV['bucket-dev-teemaero'])
    #b = s3.buckets[ENV['bucket-dev-teemaero']]
    #@s3_file = resp.objects[file_key]
  end

  # This provides the read method that the Mailgun library wants. It will call read(8142) until it receives nil,
  # so this code handles a crude sort of buffering by reading the file in the first time and then handing out the
  # requested pieces of it. Could be worse I guess.
  def read(length = nil)
    @contents = @s3_file.read.force_encoding('utf-8') if @offset == 0  # read if we haven't yet read anything; this returns a String
    if (length.nil?)
      return @contents
    else
      old_offset = @offset
      @offset += length
      return @contents[old_offset..(@offset-1)]
    end
  end

  def close
  end

  def path
    @file_key
  end

  # This ensures that the attachment has the name you want, instead of the S3 file_key.
  def original_filename
    @file_name
  end

  # The content_type does matter for Mailgun attachments! If you try to send an msword attachment with
  # content_type of 'text/plain', it will come through corrupted in the email. No idea why.
  def content_type
    case @file_name.split('.').last
    when 'doc'
      'application/msword'
    when 'pdf'
      'application/pdf'
    when 'rtf'
      'application/rtf'
    else
      'text/plain'
    end
  end

end