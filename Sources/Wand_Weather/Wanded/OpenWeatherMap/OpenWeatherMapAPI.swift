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

import WandURL


extension OpenWeatherMap {

    public
    struct API {

        public
        typealias Model = OpenWeatherMapAPI_Model

    }

}

public
protocol OpenWeatherMapAPI_Model: Rest.Model {

}

public
extension OpenWeatherMapAPI_Model {

    static
    var base: String? {
        "https://api.openweathermap.org/data/2.5/"
    }

    static
    var headers: [String : String]? {
        ["Accept": "application/json",
         "Content-Type": "application/json"]
    }

}
