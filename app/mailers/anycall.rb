
class Anycall < ApplicationMailer
    
      
    
    def welcome_email para1_title, para2_content, para3_to, para4_from, para5_cc, para6_fa
        
        unless para6_fa.nil?  # file에 무언가가 있다면
        attachments[para6_fa.original_filename] = File.read(para6_fa.path) # 이 코드가 메일에 파일을 첨부해주는 역할을 합니다.
        # file.original_filename는 파일 이름, file.path 파일 경로를 의미합니다.
        end
        email = mail from: para4_from,
               	to: para3_to,
          	    subject: para1_title,
          	    body: para2_content,
  	            cc: para5_cc
  	            

  	            #attach: MailgunS3Attachment.new(@original_filename,para6_fa.file_names.url)
                #email = mail to: para3_to,
          	    #subject: para1_title,
  	            #body: para6_fa,
  	            #cc: para5_cc,
  	            #attachment: MailgunS3Attachment.new("hello", para6_fa.file_names.url
    end
end


