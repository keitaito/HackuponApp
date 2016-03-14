//
//  NetworkingClient.swift
//  HackuponApp
//
//  Created by Keita Ito on 3/14/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import Foundation

struct NetworkClient {
    
    /// Download data from the passed url.
    static func downloadDataWithURL(url: NSURL, completion: ([Person] -> Void)? ) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            // If error is returned, print it out.
            if let error = error {
                print("error: \(error.localizedDescription): \(error.userInfo)")
            }
            
            // Parse the returned data, and create Person objecs.
            let peopleArray = Parser.parse(data)
            if let peopleArray = peopleArray {
                // Call back the completion handler.
                if let completion = completion {
                    completion(peopleArray)
                }
            }
        }
        // Start downloading.
        task.resume()
    }
}