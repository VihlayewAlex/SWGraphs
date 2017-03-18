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
        return "SWGEdge(startVertex: \(self.startVertexNumber!.alphabetOrderRepresentation()), endVertex: \(self.endVertexNumber!.alphabetOrderRepresentation()), index: \(self.index), value: \(self.value))"
    }
    
    public var parentGraph: SWGGraph
    public var startVertexNumber: Int?
    public var endVertexNumber: Int?
    public var index: Int
    public var value: Int?
    
    
    public var startVertexConnections: [SWGEdge] {
        return parentGraph.edges.filter{ $0.index != self.index && ($0.startVertexNumber == self.startVertexNumber || $0.endVertexNumber == self.startVertexNumber) }
    }
    
    public var endVertexConnections: [SWGEdge] {
        return parentGraph.edges.filter{ $0.index != self.index && ($0.startVertexNumber == self.endVertexNumber || $0.endVertexNumber == self.endVertexNumber) }
    }
    
    
    
    //// Innitializers
    
    public init(edgeFor graph: SWGGraph, start: Int?, end: Int?, index: Int, value: Int?) {
        
        self.parentGraph = graph
        
        self.startVertexNumber = start
        self.endVertexNumber = end
        
        self.index = index
        self.value = value
        
    }
    
}
