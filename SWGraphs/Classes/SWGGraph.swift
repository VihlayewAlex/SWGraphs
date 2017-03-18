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
    // Graph info
    public var type: SWGGraphType?
    public var edges = [SWGEdge]()
    
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
        
            for edgeData in edgesMatrix {

                let newEdge: SWGEdge
                
                // Checking graph type, initializing edge with edge data
                if type == .Oriented {
                    let startVertex = (type == .Oriented ? edgeData.index(of: -1) : edgeData.index(of: 1))
                    let endVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex, end: endVertex, value: nil)
                } else {
                    let startVertex = edgeData.index(of: 1)!
                    let endVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex, end: endVertex, value: nil)
                }
                
                self.edges.append(newEdge)
                
            }
        
        //// END
        
        
    }
    
    
    
    
}
