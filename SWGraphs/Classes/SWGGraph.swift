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

public class SWGGraph: CustomStringConvertible {
    
    public var description: String {
        return "Graph(type: \(graphType), edgesCount: \(edges.count))"
    }
    
    // Graph info
    var graphType: SWGGraphType?
    public var type: SWGGraphType {
        return graphType!
    }
    public var edges = [SWGEdge]()
    //public var incidenceMatrix = [[Int]]()
    
    //// Innitializers
    
    /*
     Receives incidence matrix, than
     rotates it and initializes graph with edges
    */
    public init(with incidenceMatrix: [[Int]]) {
        
        // Input incidence matrix
        //debugPrint(incidenceMatrix)
        
        //// CONVERTING FROM INCIDENCE MARIX TO EDGES ARRAY
        
            // Preparing edges array
            var edgesMatrix = [[Int]]()
            for _ in 0..<incidenceMatrix.first!.count {
                edgesMatrix.append([])
            }
            // Filling edges array
            for vertex in incidenceMatrix {
                for (vertexIndex,vertexComponent) in vertex.enumerated() {
                    // Checking for negative relations, setting type if outgoing connection is present
                    if vertexComponent == -1 {
                        self.type = .Oriented
                    }
                    edgesMatrix[vertexIndex].append(vertexComponent)
                }
            }
            // Setting type if Oriented is not set during loop check
            if type == nil {
                type = .Unoriented
            }
        
        //// END
        
        // Edges matrix ready to process
        debugPrint(edgesMatrix)
        
        
        //// INITIALIZING EDGES AND ADDING THEM TO GRAPH
        
            for (edgeIndex,edgeData) in edgesMatrix.enumerated() {

                let newEdge: SWGEdge
                
                // Checking graph type, initializing edge with edge data
                if type == .Oriented {
                    let endVertex = (type == .Oriented ? edgeData.index(of: -1) : edgeData.index(of: 1))
                    let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex, end: endVertex, index: edgeIndex, value: nil)
                } else {
                    let endVertex = edgeData.index(of: 1)!
                    let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex, end: endVertex, index: edgeIndex, value: nil)
                }
                
                self.edges.append(newEdge)
                
            }
        
        //// END
        
        
    }
    
    
    //// Methods
    
    public func addEdge(start: Int?, end: Int?, value: Int?) {
        
        let edge = SWGEdge(edgeFor: self, start: start, end: end, index: edges.count, value: value)
        self.edges.append(edge)
        
    }
    
    public func popEdge() {
        
        self.edges.popLast()
        
    }
    
    public func removeEdge(at index: Int) {
        
        self.edges.remove(at: index)
        for edgeIndex in index..<edges.count {
            edges[edgeIndex].index -= 1
        }
        
    }
    
    
}
