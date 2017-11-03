require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  let(:values) do
    ["Alexandra", "Female", "4. Senior", "CA", "English"]
  end

  it { expect(subject.sample.first).to match values }

end
