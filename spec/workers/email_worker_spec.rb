require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe EmailWorker, :type => :worker do 
  it "enqueues email worker" do
    comment = FactoryGirl.build(:comment)
    comment.id = 1755
    comment.save
    comment2 = FactoryGirl.build(:comment)
    comment2.id = 1756
    comment2.parent_id = 1755
    comment2.save
    expect {
      EmailWorker.perform_async(comment2.id)
    }.to change { ActionMailer::Base.deliveries.count}.by(1)
  end
end
