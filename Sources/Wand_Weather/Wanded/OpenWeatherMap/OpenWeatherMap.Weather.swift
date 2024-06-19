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

extension OpenWeatherMap {

    public
    struct Weather: OpenWeatherMap.API.Model {

        @inlinable
        public
        static
        var path: String {
            base! + "weather"
        }

        let id: Int
        let cod: Int

        let name: String
        let timezone: Int
        let base: String

        let weather: [Forecast]

        let main: [String: Float]
        let sys: Sys

        let wind: [String: Int]

    }

}

struct Forecast: Codable {

    let id: Int
    let main: String

    let description: String
    let icon: String

}

struct Sys: Codable {

    let id: Int
    let type: Int

    let country: String

    let sunrise: TimeInterval
    let sunset: TimeInterval

}



///// Ask
/////
///// |{ (weather: OpenWeatherMap.Weather) in
/////
///// }
/////
//@discardableResult
//@inline(__always)
//prefix
//public
//func |(handler: @escaping (OpenWeatherMap.Weather)->()) -> Wand {
//    nil | .one(handler: handler)
//}
//
///// Ask
/////
///// location | .one { (weather: OpenWeatherMap.Weather) in
/////
///// }
/////
//@discardableResult
//@inline(__always)
//prefix
//public
//func |(ask: Ask<OpenWeatherMap.Weather>) -> Wand {
//    nil | ask
//}
//
//
///// Ask
/////
///// wand | .one { (weather: OpenWeatherMap.Weather) in
/////
///// }
/////
//@discardableResult
//@inline(__always)
//public
//func | (wand: Wand, ask: Ask<OpenWeatherMap.Weather>.Get) -> Wand {
//
//    //Save ask
//    _ = wand.answer(the: ask)
//
//    //Make request
//    return wand | .every { (location: CLLocation) in
//
//        location | ask
//
//    }
//
//}

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
       get: Ask<OpenWeatherMap.Weather>.Get) -> Wand {

    OpenWeatherMap.Weather.path +   """
                                    ?lat=\(coordinate.latitude)\
                                    &lon=\(coordinate.longitude)\
                                    &appid=\(OpenWeatherMap.appId)
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
       get: Ask<OpenWeatherMap.Weather>.Get) -> Wand {

    let coordinate = location.coordinate
    return OpenWeatherMap.Weather.path +    """
                                            ?lat=\(coordinate.latitude)\
                                            &lon=\(coordinate.longitude)\
                                            &appid=\(OpenWeatherMap.appId)
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
func |(path: String,
       get: Ask<OpenWeatherMap.Weather>.Get) -> Wand {

    Wand.to(path) | get

}

#endif
