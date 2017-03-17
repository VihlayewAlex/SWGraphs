//
//  SWGVertex.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import UIKit

public class SWGVertex {
    
    public var name: String?
    public var number: Int
    public var connectedEdges: [SWGEdge]
    
    public init(name: String?, number: Int, connectedEdges: [SWGEdge]) {
        
        self.name = name
        self.number = number
        self.connectedEdges = connectedEdges
        
    }
    
}


