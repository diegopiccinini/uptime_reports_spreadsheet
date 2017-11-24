require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  describe "#credentials_path" do

    before do
      subject.instance_variable_set(:@scope,[1])
    end

    let (:credentials_path) { 'drive' }

    it { expect(subject.send(:credentials_path)).to include credentials_path }

  end

  describe "#scopes" do
    it { expect(subject.scopes.keys.count).to be 5 }
  end

  describe "#choose_scope" do

    specify do
      subject.scopes.values do |v|
        expect { subject.choose_scope }.to output(/#{v[:desc]}/).to_stdout
      end
    end

    context "without error" do

      let(:input) { "1\n" }

      before do
        allow(subject).to receive(:gets).and_return(input)
      end

      it do
        subject.choose_scope
        expect(subject.instance_variable_get(:@scope)).to eq [1]
      end
    end

    context "with error" do

      let(:input) { "x\n" }

      before do
        allow(subject).to receive(:gets).and_return(input)
      end

      it do
        expect { subject.choose_scope }.to raise_error UptimeReportsSpreadsheet::Auth::INVALID_SCOPE_ERROR
      end
    end

  end

end
