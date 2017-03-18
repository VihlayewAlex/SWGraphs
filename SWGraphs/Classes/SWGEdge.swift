//
//  SWGEdge.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import UIKit

public class SWGEdge: CustomStringConvertible {
    
    public var description: String {
        return "SWGEdge(startVertex: \(self.startVertexNumber), endVertex: \(self.endVertexNumber), value: \(self.value))"
    }
    
    public var parentGraph: SWGGraph
    public var startVertexNumber: Int?
    public var endVertexNumber: Int?
    public var value: Int?
    
    
    //// Innitializers
    
    public init(edgeFor graph: SWGGraph, start: Int?, end: Int?, value: Int?) {
        
        self.parentGraph = graph
        
        self.startVertexNumber = start
        self.endVertexNumber = end
        
        self.value = value
        
    }
    
}
