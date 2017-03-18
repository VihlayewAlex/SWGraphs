//
//  SWGEdge.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import Foundation

public class SWGEdge: CustomStringConvertible {
    
    public var description: String {
        return "SWGEdge(startVertex: \(self.startVertexNumber), endVertex: \(self.endVertexNumber), number: \(self.number), value: \(self.value))"
    }
    
    public var parentGraph: SWGGraph
    public var startVertexNumber: Int
    public var endVertexNumber: Int
    public var number: Int
    public var value: Int?
    //public var type: SWGEdgeType
    
    public var startVertexConnections: [SWGEdge] {
        return parentGraph.edges.filter{ $0.number != self.number && ($0.startVertexNumber == self.startVertexNumber || $0.endVertexNumber == self.startVertexNumber) }
    }
    
    public var endVertexConnections: [SWGEdge] {
        return parentGraph.edges.filter{ $0.number != self.number && ($0.startVertexNumber == self.endVertexNumber || $0.endVertexNumber == self.endVertexNumber) }
    }
    
    
    
    //// Innitializers
    
    public init(edgeFor graph: SWGGraph, start: Int, end: Int, number: Int, value: Int?) {
        
        self.parentGraph = graph
        
        self.startVertexNumber = start
        self.endVertexNumber = end
        
        self.number = number
        self.value = value
        
    }
    
}
