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

public
struct OpenWeatherMap_Weather: OpenWeatherMap.API.Model {

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

    @inlinable
    public
    static
    var path: String {
        base! + "weather"
    }

    let id: Int

    public
    let cod: Int

    let name: String
    let timezone: Int
    let base: String

    let weather: [Forecast]

    let main: [String: Float]
    let sys: Sys

    let wind: [String: Float]

}

/// Ask
///
/// |{ weather in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func | (handler: @escaping (OpenWeatherMap_Weather)->() ) -> Wand {
    |.one(handler: handler)
}

/// Ask
/// - `every`
/// - `one`
/// - `while`
///
/// |.one { weather in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func | (ask: Ask<OpenWeatherMap_Weather>) -> Wand {

    let wand = Wand()

    let get = Ask<OpenWeatherMap_Weather>.Get {
        ask.handler($0)
    }

    //Save ask
    _ = wand.answer(the: get)

    //Make request
    return wand | ask.option { (location: CLLocation) in

        location | get

    }

}

/// Ask
///
/// coordinate | .get { (weather: OpenWeatherMap_Weather) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(coordinate: CLLocationCoordinate2D,
       get: Ask<OpenWeatherMap_Weather>.Get) -> Wand {

    OpenWeatherMap_Weather.path +   """
                                    ?lat=\(coordinate.latitude)\
                                    &lon=\(coordinate.longitude)\
                                    &appid=\(OpenWeatherMap.appId)
                                    """
    | get

}

/// Ask
///
/// location | .get { (weather: OpenWeatherMap_Weather) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(location: CLLocation,
       get: Ask<OpenWeatherMap_Weather>.Get) -> Wand {

    let wand = location.wand

    let coordinate = location.coordinate
    let path = OpenWeatherMap_Weather.path +    """
                                                ?lat=\(coordinate.latitude)\
                                                &lon=\(coordinate.longitude)\
                                                &appid=\(OpenWeatherMap.appId)
                                                """
    wand.store(path)

    return wand | get

}


/// Chain
@discardableResult
@inline(__always)
public
func |<T: Asking>(l: Ask<OpenWeatherMap_Weather>, r: Ask<T>) -> Wand {

    let wand = |l
    T.wand(wand, asks: r)

    return wand
}

#endif
