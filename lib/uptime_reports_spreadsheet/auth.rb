require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
module UptimeReportsSpreadsheet

  class Auth

    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'
    CLIENT_SECRETS_PATH = 'client_secret.json'
    INVALID_SCOPE_ERROR = "Sorry, this is an invalid scope"

    attr_accessor :service, :response
    attr_reader :scope, :user_id

    def initialize scope=nil
      @scope=scope || [5]
      @service = Google::Apis::SheetsV4::SheetsService.new
      @service.client_options.application_name = APPLICATION_NAME
      @user_id='default'
    end

    def authorize
      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: credentials_path)
      authorizer = Google::Auth::UserAuthorizer.new(client_id, scope_url, token_store)
      authorizer.get_credentials(user_id)
    end

    def sample
      @service.authorization = authorize

      spreadsheet_id = '1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms'
      range = 'Class Data!A2:E'
      response = service.get_spreadsheet_values(spreadsheet_id, range)
      response.values
    end

    def create
      request_body = Google::Apis::SheetsV4::Spreadsheet.new
      @response = service.create_spreadsheet(request_body)
    end

    def choose_scope

      puts "Choose one scope:"
      scopes.each_pair do |k,v|
        puts "#{k}.- #{v[:name]}"
        puts "\t#{v[:desc]}"
      end

      s=gets(chomp: true)

      s=s.split
      @scope=s.map do |option|
        raise INVALID_SCOPE_ERROR if !scopes.keys.include?(option.to_i)
        option.to_i
      end

    end

    def save_credentials

      choose_scope

      FileUtils.mkdir_p(File.dirname(credentials_path))

      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: credentials_path)
      authorizer = Google::Auth::UserAuthorizer.new( client_id, scope_url, token_store)
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Visit #{url} to get the code"

      code=gets(chomp: true)

      authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
      save_code code

    end

    def scopes
      {
        1 => {
          name: 'AUTH_DRIVE',
          desc: 'View and manage the files in your Google Drive',
          url: 'https://www.googleapis.com/auth/drive'
        },
        2 => {
          name: 'AUTH_DRIVE_FILE',
          desc: 'View and manage Google Drive files and folders that you have opened or created with this app',
          url: 'https://www.googleapis.com/auth/drive.file'
        },
        3 => {
          name: 'AUTH_DRIVE_READONLY',
          desc: 'View the files in your Google Drive',
          url: 'https://www.googleapis.com/auth/drive.readonly'
        },
        4 => {
          name: 'AUTH_SPREADSHEETS',
          desc: 'View and manage your spreadsheets in Google Drive',
          url: 'https://www.googleapis.com/auth/spreadsheets'
        },
        5 => {
          name: 'AUTH_SPREADSHEETS_READONLY',
          desc: 'View your Google Spreadsheets',
          url: 'https://www.googleapis.com/auth/spreadsheets.readonly'
        }
      }
    end

    private

    def credentials_path
      name=scope_url.map { |a| a.split('/').last }.join('.and.')
      File.join(Dir.home, '.credentials', "sheets.googleapis.#{name}.yaml")
    end

    def scope_url
      if @scope.count<1
        scopes[@scope.first.to_i][:url]
      else
        @scope.map { |option| scopes[option.to_i][:url] }
      end
    end

    def save_code code
      name=@scope.map { |a| scopes[a][:name] }.join('_AND_')
      name="GOOGLE_#{name}"
      File.open('.env','a') do |f|
        f.write "#{name}=#{code}"
        f.close
      end
    end
  end
end
