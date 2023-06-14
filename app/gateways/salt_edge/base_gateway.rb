require 'net/http'

module SaltEdge
  class BaseGateway
    DEFAULT_HEADERS = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "App-id" => "#{Rails.configuration.salt_edge_app_id}",
      "Secret" => "#{Rails.configuration.salt_edge_secret}"
    }.freeze

    BASE_URL = "https://www.saltedge.com/api/v5/"

    def get(path)
      uri = uri_for_path(path)
      use_ssl = uri.scheme == "https"
      opts = {use_ssl: use_ssl}
      response = Net::HTTP.start(uri.hostname, uri.port, opts) do |http|
        http.request_get(uri, DEFAULT_HEADERS)
      end
      parse_response(response)
    end

    def post(path, data)
      uri = uri_for_path(path)
      use_ssl = uri.scheme == "https"
      opts = {use_ssl: use_ssl}
      response = Net::HTTP.start(uri.hostname, uri.port, opts) do |http|
        http.post(uri, data.to_json, DEFAULT_HEADERS)
      end
      parse_response(response)
    end

    def put(path, data)
      uri = uri_for_path(path)
      use_ssl = uri.scheme == "https"
      opts = {use_ssl: use_ssl}
      response = Net::HTTP.start(uri.hostname, uri.port, opts) do |http|
        http.put(uri, data.to_json, DEFAULT_HEADERS)
      end
      parse_response(response)
    end

    def delete(path)
      uri = uri_for_path(path)
      use_ssl = uri.scheme == "https"
      opts = {use_ssl: use_ssl}
      response = Net::HTTP.start(uri.hostname, uri.port, opts) do |http|
        http.delete(uri, DEFAULT_HEADERS)
      end
      parse_response(response)
    end

    private

    def parse_response(response)
      if response.code =~ /2\d\d/
        parsed_body = JSON.parse(response.body, symbolize_names: true)
        parsed_body[:data]
      else
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    def uri_for_path(path)
      URI(File.join(BASE_URL, path))
    end
  end
end