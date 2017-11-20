require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  subject { UptimeReportsSpreadsheet::Auth.new 1 }

  describe "#save_credentails" do

    let(:input) { "test.com" }

    before do
      allow(subject).to receive(:choose_scope) { '' }
      allow(subject).to receive(:gets).and_return('test_code')
    end

    specify { expect { subject.save_credentials }.to raise_error Signet::AuthorizationError }

    it { expect(File.exists?(subject.send(:credentials_path))).to be false }

  end

end
