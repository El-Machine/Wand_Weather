// swift-tools-version: 5.6

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

import PackageDescription

let package = Package(
    name: "Wand_Weather",

    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v7),
    ],

    products: [
        .library(name: "Wand_Weather", targets: ["Wand_Weather"])
    ],

    dependencies: [
        .package(url: "https://github.com/the-wand/Any.git", from: "1.0.3"),
        .package(url: "https://github.com/the-wand/Wand.git", from: "3.0.5"),

        .package(url: "https://github.com/the-wand/Location.git", from: "3.0.5"),
        .package(url: "https://github.com/the-wand/URL.git", from: "3.0.5"),
    ],

    targets: [
        .target(name: "Wand_Weather", dependencies:
                    [
                        "Wand",
                        .product(name: "WandLocation", package: "Location"),
                        .product(name: "WandURL", package: "URL"),
                    ]
               ),
        .testTarget(name: "wandTests", dependencies:
                        [
                            "Wand_Weather",
                            .product(name: "Any_", package: "Any")
                        ]
                   )
    ]
)
