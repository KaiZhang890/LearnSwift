//
//  AppDelegate.swift
//  LearnSwift
//
//  Created by zhangkai on 7/2/15.
//  Copyright (c) 2015 Kai Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        println("Hello World")
        
        var myVariable = 42
        myVariable = 50
        let myConstant = 42
        
        let explicitFloat: Float = 4
        
        // Values are never implicitly converted to another type.
        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)
        
        let number = 44
        let total = "Here are \(number) aples."
        
        var shoppingList = [String]()
        var occupations = [String: String]()
        //shoppingList[0] = "Mi TV"
        occupations["kai"] = "programmer"
        
        let scores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in scores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        println(teamScore)
        
        var optionalName: String? = "John Appleseed"
        optionalName = nil
        var greeting = "Hello"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        println(greeting)
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            let vegetableComment = "Add some raisins and make ants on a log."
        case "cucumber", "watercress":
            let vegetableComment = "That would make a good tea sandwich."
        case let x where x.hasSuffix("pepper"):
            let vegetableComment = "Is it a spicy \(x)?"
        default:
            let vegetableComment = "Everything tastes good in soup."
        }
        
        let interestingNumbers = [
            "Pirme": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        var largestKind = ""
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                    largestKind = kind
                }
            }
        }
        println("\(largest) - \(largestKind)")
        
        
        var firstForLoop = 0
        for i in 0..<4 {
            firstForLoop += i
        }
        println(firstForLoop)
        
        println(greet("Bob", day: "Tuesday"))
        
        let statistics = calculateStatistics([5, 3, 100, 3, 9])
        println(statistics.2)
        println(statistics.sum)
        
        println(sumOf(1, 2, 3))
        
        func returnFifteen() -> Int {
            var y = 10
            
            func add() {
                y += 5
            }
            
            add()
            return y
        }
        println(returnFifteen())
        
        // Functions are a first-class type.
        func makeIncrementer() -> (Int -> Int) {
            func addOne(number: Int) -> Int {
                return 1 + number
            }
            return addOne
        }
        var increment = makeIncrementer()
        println(increment(8))
        
        func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
            for item in list {
                if condition(item) {
                    return true
                }
            }
            
            return false
        }
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        var numbers = [20, 19, 17, 12, 30]
        if hasAnyMatches(numbers, lessThanTen) {
            println("has matches")
        } else {
            println("no matches")
        }
        
        numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result;
        })
        
        let mappedNumbers = numbers.map({
            (number: Int) -> Int in
            return number % 2 == 0 ? 0 : number
        })
        println(mappedNumbers)
        
        numbers.sort { $0 > $1 }
        println(numbers)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: my functions
    func greet(name: String, day: String) -> String {
        return "Hello \(name), today is \(day)."
    }
    // int scores[], scores: [Int]
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            
            sum += score
        }
        
        return (min, max, sum)
    }
    
    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }
}

