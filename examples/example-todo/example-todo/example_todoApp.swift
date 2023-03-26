//
//  example_todoApp.swift
//  example-todo
//
//  Created by richard on 17/03/23.
//
//

import SwiftUI
import featurehub_swift_sdk
import Logging
import LoggingOSLog



var context =
try! EdgeFeatureHubConfig("http://localhost:8085",
                     ["8c5d3253-4974-4455-a684-954ce6a6110d/EWddcsNnNza60FVIocq62ApdrzKlr9qxCfSlo323"])
    .cacheTimeout(10).newContext()

// 2) we need to create a logger, the label works similarly to a DispatchQueue label
let logger = Logger(label: "com.example.BestExampleApp.main")

@main
struct exampleTodoApp: App {
    init() {
      
      // using trace level logs so we can see what featurehub is doing
      LoggingSystem.bootstrap( { label in
        var l = LoggingOSLog(label: label)
        l.logLevel = .trace
        return l
      })

      context.user("me@me.com").attribute("factoryId", "10")

      logger.trace("Initializing the FeatureHub Connection")
      Task.detached(operation: { // background this update
       await context.build()
      })
      }
  
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
