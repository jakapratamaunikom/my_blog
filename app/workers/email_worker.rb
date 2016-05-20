class EmailWorker
   include Sidekiq::Worker

   def perform(parent_id)
    parent_comment = Comment.find(parent_id)
    CommentMailer.notification_of_comments(parent_comment).deliver_later
   end
end 
