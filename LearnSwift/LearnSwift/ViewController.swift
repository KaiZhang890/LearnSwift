//
//  ViewController.swift
//  LearnSwift
//
//  Created by zhangkai on 7/2/15.
//  Copyright (c) 2015 Kai Zhang. All rights reserved.
//

import UIKit
import Alamofire

class NamedShape {
    var numberOfSides = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simipleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simipleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

class Circle: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
    }
    
    func area() -> Double {
        return M_PI * radius * radius
    }
    
    override func simipleDescription() -> String {
        return "A circle with radius of length \(radius)"
    }
}

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simipleDescription() -> String {
        return "An equilaterial triangle with sides of length \(sideLength)."
    }
}

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            
            return String(self.rawValue)
        }
    }
    
    func isBigger(otherRank: Rank) -> Bool {
        return self.rawValue > otherRank.rawValue
    }
    
    static let allValues = [Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King]
}

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .Diamonds, .Hearts:
            return "red"
        case .Spades, .Clubs:
            return "black"
        }
    }
    
    static let allValues = [Spades, Hearts, Diamonds, Clubs]
}

// one of the most important differences between structures and classes is that structures are always copied when they are passed around in your code, but classes are passed by reference
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    static func createDeck() -> [Card] {
        var cards = [Card]()
        
        for rank in Rank.allValues {
            for suit in Suit.allValues {
                var card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }
        
        return cards
    }
}

enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

enum SimpleEnumeration: ExampleProtocol {
    case Base, Adjusted
    
    func getDescription() -> String {
        switch self {
        case Base:
            return "Base description of enum"
        case Adjusted:
            return "Adjusted description of enum"
        }
    }
    
    var simpleDescription: String {
        get {
            return self.getDescription()
        }
    }
    
    mutating func adjust() {
        self = SimpleEnumeration.Adjusted
    }
}

extension Double {
    var absoluteValue: Double {
        return abs(self)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var shape = NamedShape(name: "No name")
        shape.numberOfSides = 7
        println(shape.simipleDescription())
        
        let circle = Circle(radius: 2, name: "my circle")
        println(circle.area())
        println(circle.simipleDescription())
        
        var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        println(triangle.perimeter)
        triangle.perimeter = 9.9
        println(triangle.sideLength)
        
        var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        println(triangleAndSquare.square.sideLength)
        println(triangleAndSquare.triangle.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        println(triangleAndSquare.triangle.sideLength)
        
        let ace = Rank.Ace
        println("\(ace.simpleDescription()) \(ace.rawValue)")
        println(Rank.Queen.isBigger(Rank.King) ? "is bigger" : "not bigger")
        
        if let convertRank = Rank(rawValue: 3) {
            println(convertRank.simpleDescription())
        }
        
        println(Suit.Hearts.color())
        
        let threeOfSpades = Card(rank: .Three, suit: .Spades)
        println(threeOfSpades.simpleDescription())
        
        for card in Card.createDeck() {
            println(card.simpleDescription())
        }
        
        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        let failure = ServerResponse.Error("Out of cheese.")
        switch success {
        case let .Result(sunrise, sunset):
            println("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let .Error(error):
            println("Failure... \(error)")
        }
        
        println((-12.2).absoluteValue)
        
//        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
//            .response { (request, response, data, error) in
//                println(request)
//                println(response)
//                println(error)
//            }
        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseJSON { (_, _, JSON, _) in
                loggingPrintln(JSON)
        }
        
        loggingPrintln("show log info1")
        loggingPrintln("show log info2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

