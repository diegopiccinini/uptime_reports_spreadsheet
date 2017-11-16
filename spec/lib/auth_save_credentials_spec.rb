require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  subject { UptimeReportsSpreadsheet::Auth.new 1 }

  describe "#save_credentails" do

    before do
      allow(subject).to receive(:choose_scope) { '' }
    end

    specify { expect { subject.save_credentials }.to output(/Visit/).to_stdout }

  end

end
