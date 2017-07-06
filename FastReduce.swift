//
//  FastReduce.swift
//  Fast Reducer
//
//  Written in Swift 4
//
//  fastReduce is a function that is tested to be over 10,000x faster than the Swift Standard Library's reduce function
//
//  Created by Ben Leggiero on 2017-07-01.
//  Copyright © 2017 Ben Leggiero. All rights reserved.
//

import Foundation



public extension Sequence {
    
    /// The block called in each iteration of `fastReduce` to transform a Sequence into some other object (`Result`)
    ///
    /// - Parameters:
    ///    - result:  The current running result. This is mutable on-purpose, and should be mutated each iteration.
    ///               Treat this like a `return` in a normal Swift Standard Library `reduce` function.
    ///    - element: The current element in the sequence. Use this to determine how `result` is mutated each iteration
    ///
    /// - Throws: If any error occurs in the closure.
    public typealias FastReducer<Result> = (_ result: inout Result, _ element: Element) throws -> Void
    
    
    
    /// Operates like the Swift Standard Library's `reduce`, but is much faster.
    ///
    /// For instance, when converting 1,000,000 UUIDs to a string concatenation of all their string values, this
    /// function took `0.5` seconds on average, and the Swift Standard Library version took `5500` seconds on average.
    /// This is over 1,000,000% speed improvement.
    ///
    /// - Note: This is fast because it mutates one object rather than allocating a new one each time. This means that
    ///         `reducer` doesn't _return_ a new result, but instead _mutates_ its `result` each time. After the loop
    ///         completes, the `result` is returned as-is; the last mutation applied to it is what comes out.
    ///         For example, here are the usages this function and the Swift Standard Library counterpart compared:
    ///
    ///         let fastReduceStringValue = lotsOfUuids.fastReduce("") { stringValue, uuid in
    ///             stringValue += uuid.uuidString
    ///         }
    ///
    ///         let stdlibReduceStringValue = lotsOfUuids.reduce("") { stringValue, uuid in
    ///             return stringValue + uuid.uuidString
    ///         }
    ///
    /// - Parameters:
    ///   - startingValue: The first value; this will be passed to `reducer` on the first iteration
    ///   - reducer:       The function that will reduce this array to a single value
    ///
    /// - Returns: This array converted by `reducer` into some other object
    ///
    /// - Throws: Iff `reducer` ever throws an error, that is rethrown by this function.
    public func fastReduce<Result>(_ startingValue: Result, reducer: FastReducer<Result>) rethrows -> Result {
        var result = startingValue
        for element in self {
            try reducer(&result, element)
        }
        return result
    }
}
