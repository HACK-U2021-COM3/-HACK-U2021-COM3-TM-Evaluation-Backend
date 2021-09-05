class MeasureService
  include RequestApi

  def initialize(req_params)
    #google map api の パラメータを設定
    @query = {
      origin: req_params.from,
      destination: req_params.to,
      waypoints: parse_for_waypoints(req_params.waypoints),
      key: ENV["GOOGLE_API_KEY"],
      mode: "walking",
      language: "ja"
    }
  end

  #initialize時にwaypointsをGoogleApiが指定した形式に変換
  def parse_for_waypoints(waypoints)
    waypoints.sort_by!{|waypoint| waypoint[:order]}

    tmp = []
    waypoints.each {|waypoint| tmp.append(waypoint[:point]) }
    waypoints_str = tmp.join("|")

    waypoints_str
  end

  def call_direction_api

    response_base = request('https://maps.googleapis.com/maps/api/directions/json', @query)

    #statusが異常系の場合 ex)ZERO_RESULTS ,INVALID_REQUEST
    raise DirectionApiError.new("call_direction_api error: #{response_base["status"]}") unless response_base["status"] == "OK"

    got_measures = []
    response_base["routes"][0]["legs"].each { |result|
      got_measure = {}
      # 緯度経度
      got_measure["start_location"], got_measure["end_location"] = result["start_location"], result["end_location"]
      # 住所
      got_measure["start_address"], got_measure["end_address"] = result["start_address"], result["end_address"]
      # 距離
      got_measure["distance"] = result["distance"]["value"]
      # 時間
      got_measure["duration"] = result["duration"]["value"]

      routes_point_list = []
      result["steps"].each { |step|
        routes_point_list.append(step["polyline"]["points"])
      }
      got_measure["routes_points"] = routes_point_list

      got_measures.append(got_measure)
    }

    got_measures
  end
end