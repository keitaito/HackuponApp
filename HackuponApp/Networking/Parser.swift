//
//  Parser.swift
//  HackuponApp
//
//  Created by Keita Ito on 3/14/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import Foundation

// TODO: Update the parse method to be a Generic function.
struct Parser {
    /// Parse the passed NSData object, and returned Array<Person>?.
    static func parse(data: NSData?) -> [Person]? {
        // Check if data is non-nil value.
        guard let data = data else { return nil }
        
        // Try JSON-serializing.
        var jsonObject: AnyObject?
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        } catch {
            // If error is catched, print out.
            print("Failed JSON serializing. Error: \(error)")
        }
        
        // Type cast jsonObject to an array of type Dictionary of type String key and AnyObject value.
        guard let people = jsonObject as? Array<Dictionary<String, AnyObject>> else { return nil }
        
        // Map Array<[String : AnyObject]> to Array<Person>.
        let mappedPeople: [Person] = people.map {
            // TODO: Change the else clause not to return a Person object. return a nil, or error.
            // Check if values are non-nil.
            guard let personName = $0["name"] as? String else { return Person(name: "", id: 0) }
            guard let personId = $0["id"] as? Int else { return Person(name: "", id: 0) }
            // Instantiate a Person object with values.
            return Person(name: personName, id: personId)
        }
        return mappedPeople
    }
}
