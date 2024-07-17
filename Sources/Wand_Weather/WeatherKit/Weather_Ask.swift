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

import Wand_CoreLocation
import Wand

/// Ask
///
///  |.one { (weather: Weather) in
///
/// }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
@available(visionOS, unavailable)
extension Weather: Asking, Wanded {

    @inline(__always)
    public
    static
    func wand<T>(_ wand: Wand, asks ask: Ask<T>) {

        //Save ask
        guard wand.answer(the: ask) else {
            return
        }

        //Request for a first time

        //Prepare context
        wand | ask.option { [weak wand] (location: CLLocation) in

            Task { [weak wand] in  do {

                guard let wand else {
                    return
                }

                let service: WeatherService = wand.obtain()

                //Make request
                let weather = try await service.weather(for: location)
                wand.add(weather)

            } catch {
                wand?.add(error)
            }}

        }

    }

}

#endif
