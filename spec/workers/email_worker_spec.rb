require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe EmailWorker, :type => :worker do
  before(:each) {
    ActionMailer::Base.deliveries.clear 
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
  }
  
  it "enqueues email worker" do
    comment = FactoryGirl.create(:comment)
    comment2 = FactoryGirl.create(:comment, parent_id: comment.id)
    expect {
      EmailWorker.perform_async(comment2.id)
    }.to change { ActionMailer::Base.deliveries.count}.by(1)
  end
end
