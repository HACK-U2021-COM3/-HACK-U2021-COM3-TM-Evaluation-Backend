class MeasureService
  include RequestApi

  def initialize(req_params)
    #google map api の パラメータを設定
    waypoints_hash = parse_for_waypoints(req_params.waypoints)
    @query = {
      origin: req_params.from,
      destination: req_params.to,
      waypoints: waypoints_hash[:waypoints_str],
      key: ENV["GOOGLE_API_KEY"],
      mode: "walking",
      language: "ja"
    }
    #フロントに描画させるための値を保持
    @stay_time_list = [
      req_params.from[:from_stay_time],
      waypoints_hash[:stay_times],
      req_params.to[:to_stay_time],
    ].flatten
  end

  #initialize時にwaypointsをGoogleApiが指定した形式に変換
  def parse_for_waypoints(waypoints)
    waypoints.sort_by!{|waypoint| waypoint[:order]}

    points = []
    stay_times = []
    waypoints.each do |waypoint|
      points.append(waypoint[:point])
      stay_times.append(waypoint[:point_stay_time])
    end
    waypoints_str = points.join("|")
    {waypoints_str: waypoints_str,stay_times: stay_times}
  end

  def call_direction_api

    response_base = request('https://maps.googleapis.com/maps/api/directions/json', @query)

    #statusが異常系の場合 ex)ZERO_RESULTS ,INVALID_REQUEST
    raise DirectionApiError.new("call_direction_api error: #{response_base["status"]}") unless response_base["status"] == "OK"

    got_measures = []
    response_base["routes"][0]["legs"].each_with_index { |result, idx|
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

      #フロントに描画させるための値を保持
      got_measure["start_stay_time"] = @stay_time_list[idx]
      got_measure["end_stay_time"] = @stay_time_list[idx + 1]

      got_measures.append(got_measure)
    }

    got_measures
  end
end