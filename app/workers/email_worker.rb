class EmailWorker
   include Sidekiq::Worker

   def perform(comment_id)
    comment = Comment.find(comment_id)

    if comment.parent_id != nil
      parent_comment = Comment.find(comment.parent_id)
      CommentMailer.notification_of_comments(parent_comment).deliver_later
    end 
   end
end 
