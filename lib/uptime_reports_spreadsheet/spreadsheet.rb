require 'google/apis/drive_v3'
require 'uptime_reports_spreadsheet/auth'

module UptimeReportsSpreadsheet

  class Spreadsheet

    attr_accessor :service, :response, :spreadsheet, :auth

    def initialize scopes=[1,4]
      @auth=UptimeReportsSpreadsheet::Auth.new scopes
      @service=auth.service

    end

    def sample
      service.authorization = auth.authorize

      spreadsheet_id = '1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms'
      range = 'Class Data!A2:E'
      response = service.get_spreadsheet_values(spreadsheet_id, range)
      response.values
    end

    def create
      service.authorization = auth.authorize
      request_body = Google::Apis::SheetsV4::Spreadsheet.new
      @spreadsheet = service.create_spreadsheet(request_body)
    end

    def set_title title
      spreadsheet.properties.update!(title: title)
    end

    def title
      spreadsheet.properties.title
    end

    def delete
      service = Google::Apis::DriveV3::DriveService.new
      service.authorization = auth.authorize
      service.delete_file spreadsheet.spreadsheet_id
    end

  end
end
