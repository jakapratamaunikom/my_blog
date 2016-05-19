require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CommentMailer, :type => :mailer do 

  describe "send email" do

    let(:comment) {
      FactoryGirl.create(:comment)
    }

    let(:mail) {
      described_class.notification_of_comments(comment).deliver_now
    }

    before(:each) {
      ActionMailer::Base.deliveries.clear
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
    }

    it "renders the subject" do
      expect(mail.subject).to eq('Answer')
    end  

    it "renders the receiver email" do
      expect(mail.to).to eq([comment.email])
    end

    it "send mail delivery later" do
      expect {
        described_class.notification_of_comments(comment).deliver_later
      }.to change { ActionMailer::Base.deliveries.count}.by(1)
    end
  end
end
