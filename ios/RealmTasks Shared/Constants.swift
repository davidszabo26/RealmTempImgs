////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation

struct Constants {
    // Specify your Realm object server IP address, eg. "10.0.100.43". The default `localIPAddress` is the IP address of your device.
    static let syncHost = localIPAddress
    // Specify your Realm object server port. Default is 9080.
    static let port = 9080

    static let syncRealmPath = "realmtasks"
    static let defaultListName = "My Tasks"
    static let defaultListID = "80EB1620-165B-4600-A1B1-D97032FDD9A0"

    static let syncServerURL = URL(string: "realm://\(syncHost):\(port)/~/\(syncRealmPath)")
    static let syncAuthURL = URL(string: "http://\(syncHost):\(port)")!

    static let appID = Bundle.main.bundleIdentifier!
}
