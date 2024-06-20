///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

#if canImport(CoreLocation)
import CoreLocation.CLLocation

import Wand_CoreLocation
import WandURL
import Wand

extension Yandex {

    public
    struct Fact: Codable {

        let obs_time: Int
        let uptime: Int
        let temp: Int
        let feels_like: Int

        let temp_water: Int?

        let icon: String
        let condition: String
        let cloudness: Float
        let prec_type: Int
        let prec_prob: Float
        let prec_strength: Float
        let is_thunder: Bool
        let wind_speed: Float
        let wind_dir: String
        let pressure_mm: Int
        let pressure_pa: Int
        let humidity: Int
        let daytime: String
        let polar: Bool
        let season: String
        let source: String
        let uv_index: Int
        let wind_gust: Float
        
    }

    public
    struct Weather: Yandex.API.Model {

        @inlinable
        public
        static
        var path: String {
            base! + "forecast"
        }

        public
        let fact: Fact

    }

}

/// Ask
///
/// coordinate | .get { (weather: OpenWeatherMap.Weather) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(coordinate: CLLocationCoordinate2D,
       get: Ask<Yandex.Weather>.Get) -> Wand {

    Yandex.Weather.path + """
                          ?lat=\(coordinate.latitude)\
                          &lon=\(coordinate.longitude)
                          """
    | get

}

/// Ask
///
/// location | .get { (weather: OpenWeatherMap.Weather) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(location: CLLocation,
       get: Ask<Yandex.Weather>.Get) -> Wand {

    let coordinate = location.coordinate
    return Yandex.Weather.path + """
                                 ?lat=\(coordinate.latitude)\
                                 &lon=\(coordinate.longitude)
                                 """
    | get

}

#endif
