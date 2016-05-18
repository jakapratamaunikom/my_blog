require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CommentMailer, :type => :mailer do 

  describe "send email" do

    let(:comment) {
      FactoryGirl.build(:comment)
    }

    let(:mail) {
      described_class.notification_of_comments(comment).deliver_later
    }

    it "renders the subject" do
      expect(mail.subject).to eq('Answer')
    end  

    it "renders the receiver email" do
      expect(mail.to).to eq([comment.email])
    end
  end
end
