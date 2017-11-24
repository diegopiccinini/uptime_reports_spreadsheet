require 'spec_helper'

describe UptimeReportsSpreadsheet::Spreadsheet do

  describe "#create" do

    before { subject.create }
    after { subject.delete }

    it { expect(subject.spreadsheet.sheets.count).to be == 1 }

    describe "#set_title" do

      let (:title) { 'Hello Google Spreadsheet' }

      before { subject.set_title(title) }

      it { expect(subject.title).to match title }

    end

  end

  describe "#sample" do

    subject { UptimeReportsSpreadsheet::Spreadsheet.new [5] }

    let(:values) do
      ["Alexandra", "Female", "4. Senior", "CA", "English"]
    end

    it { expect(subject.sample.first).to match values }

  end


end
