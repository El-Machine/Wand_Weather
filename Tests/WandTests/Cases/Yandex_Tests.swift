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
import WandURL
import Wand

import XCTest

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
final
class Yandex_Tests: XCTestCase {

    func test_Weather_once() {
        let e = expectation()

        |{ (weather: Yandex_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocationCoordinate2D_to_Weather_once() {
        let e = expectation()

        let coordinate: CLLocationCoordinate2D = (lat: 55.0138, lon: 82.9314)|
        coordinate | .get { (weather: Yandex_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocation_to_Weather_once() {
        let e = expectation()

        let location: CLLocation = (lat: 55.0138, lon: 82.9314)|
        location | .get { (weather: Yandex_Weather) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_Path_to_Weather_once() {
        let e = expectation()

        let path = "https://api.weather.yandex.ru/v2/forecast?lat=52.37125&lon=4.89388"
        path | .get { (weather: Yandex_Weather) in

            e.fulfill()

        }

        waitForExpectations()
    }

}
    
#endif
