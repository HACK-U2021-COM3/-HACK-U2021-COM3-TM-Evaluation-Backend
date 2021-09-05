class SearchService
  include RequestApi 

  def initialize(req_params)

    #GoogleMapApiのパラメータを設定
    @query = {
      input: req_params.query_place,
      key: ENV["GOOGLE_API_KEY"],
      inputtype: "textquery",
      fields:  "formatted_address,name,geometry",
      language: "ja",    
    }
    puts @query

  end

  def call_place_api

    response_base = request('https://maps.googleapis.com/maps/api/place/textsearch/json', @query)
    
    #statusが異常系の場合 ex)ZERO_RESULTS ,INVALID_REQUEST
    raise PlaceApiError.new("call_place_api error: #{response_base["status"]}") unless response_base["status"] == "OK"

    #複数の場所候補を取得
    got_places = []
    response_base["results"].each { |result|
      got_place = {}
      # 経度
      got_place["location"] = result["geometry"]["location"]
      # 住所
      got_place["address"] = result["formatted_address"]
      # 名前
      got_place["name"] = result["name"]
      got_places.append(got_place)
    }
    
    got_places
  end
    
    
end