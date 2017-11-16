require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  subject do
    scope= 'https://www.googleapis.com/auth/spreadsheets'
    UptimeReportsSpreadsheet::Auth.new scope
  end

  describe "#create" do

    before { subject.create }

    it { expect(subject.response.to_json).to match 'name' }

  end

end
