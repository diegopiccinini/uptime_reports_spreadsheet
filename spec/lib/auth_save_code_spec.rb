require 'spec_helper'

describe UptimeReportsSpreadsheet::Auth do

  let(:env) { File.read('.env') }

  let(:expected_text) { 'GOOGLE_AUTH_DRIVE=test' }

  def clean_file
    replaced_env = env.gsub expected_text, ''
    File.open('.env','w') do |f|
      f.write replaced_env
      f.close
    end
  end

  it { expect(env).not_to include expected_text }

  describe "#save_code" do

    before do
      subject.instance_variable_set(:@scope,[1])
      subject.send(:save_code,'test')
    end

    after { clean_file }

    it { expect(env).to include expected_text }

  end

end
