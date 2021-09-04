module RequestApi
  extend ActiveSupport::Concern

  def request(endpoint, query)
    client = HTTPClient.new
    requests = client.get(endpoint, query)
    
    JSON.parse(requests.body)
  end

end