//
//  DisjointSet.swift
//  Assignment2
//
//  Created by Jiang Peng Han on 2025-02-27.
//

class DisjointSet {
    
    private var setArray: [Int]
    
    init(setSize: Int = 256) {
        setArray = Array(repeating: -1, count: setSize)
    }
    
    func unionSets(s1: Int, s2: Int) {
        if s1 < s2 {
            setArray[s2] = s1
        } else {
            setArray[s1] = s2
        }
    }
    
    func find(x: Int) -> Int {
        if setArray[x] < 0 {
            return x
        } else {
            return find(x: setArray[x])
        }
    }
}
