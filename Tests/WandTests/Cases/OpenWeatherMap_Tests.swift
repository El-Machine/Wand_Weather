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

#if canImport(WeatherKit)
import CoreLocation.CLLocation
import WeatherKit

import Any_
import Wand_CoreLocation
import Wand_Weather
import Wand

import XCTest

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
final
class OpenWeatherMap_Tests: XCTestCase {

    func test_Weather() {
        let e = expectation()

        |{ (weather: OpenWeatherMap_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocationCoordinate2D_to_Weather_once() {
        let e = expectation()

        let coordinate: CLLocationCoordinate2D = (lat: 55.0138, lon: 82.9314)|
        coordinate | .get { (weather: OpenWeatherMap_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocation_to_Weather_once() {
        let e = expectation()

        let location: CLLocation = (lat: 55.0138, lon: 82.9314)|
        location | .get { (weather: OpenWeatherMap_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_Path_to_Weather_once() {
        let e = expectation()

        let path = "https://api.openweathermap.org/data/2.5/weather?lat=55.0138&lon=82.9314&appid=983f328f973b9904144768159db115b5"
        path | .get { (weather: OpenWeatherMap_Weather) in
            
            if weather.cod == 200 {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

}
    
#endif
