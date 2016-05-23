class CommentMailer < ActionMailer::Base

  default from: 'notifications@example.com'
 
  def notification_of_comments(comment)
    mail(to: comment.email, subject: 'Answer')
  end  
end
