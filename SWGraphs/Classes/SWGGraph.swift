//
//  SWGGraph.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import UIKit

public enum SWGGraphType {
    case Oriented
    case Unoriented
}

public class SWGGraph {
    
    public var type: SWGGraphType
    
    public var vertices: [SWGVertex]
    public var edges: [SWGEdge]
    
    public init(type: SWGGraphType, vertices: [SWGVertex], edges: [SWGEdge]) {
        
        self.type = type
        self.vertices = vertices
        self.edges = edges
        
    }
    
}
