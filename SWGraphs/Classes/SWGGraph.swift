//
//  SWGGraph.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import Foundation


public enum SWGGraphType {
    case Oriented
    case Unoriented
}

public class SWGGraph: CustomStringConvertible {
    
    public var description: String {
        return "Graph(type: \(graphType), edgesCount: \(graphEdges.count))"
    }
    
    // Graph info
    private var graphType: SWGGraphType?
    public var type: SWGGraphType {
        return graphType!
    }
    private var graphEdges = [SWGEdge]()
    public var edges: [SWGEdge] {
        return graphEdges
    }
    public var vertexes: [SWGVertex] {
        
        var vertexes = [SWGVertex]()
        for edge in edges {
            
            // Start
            let START_VERTEX_NUMBER = edge.startVertexNumber
            var startConnections = [SWGVertexConnection]()
            var connections = edge.startVertexConnections
            connections.append(edge)
            for startConnection in connections {
                // iterating through connected edges
                
                let direction: SWGVertexConnectionDirection
                let connectedVertexNumber: Int
                if startConnection.startVertexNumber == START_VERTEX_NUMBER {
                    direction = .Out
                    connectedVertexNumber = startConnection.endVertexNumber
                } else {
                    direction = .In
                    connectedVertexNumber = startConnection.startVertexNumber
                }
                
                let newConnection = SWGVertexConnection(direction: direction, connectedToVertex: connectedVertexNumber, connectionValue: startConnection.value)
                
                startConnections.append(newConnection)
            }
            
            let startVertex = SWGVertex(number: edge.startVertexNumber, connectedVertexes: startConnections)
            vertexes.append(startVertex)
            
            // End

            let END_VERTEX_NUMBER = edge.endVertexNumber
            var endConnections = [SWGVertexConnection]()
            connections = edge.endVertexConnections
            connections.append(edge)
            for endConnection in connections {
                // iterating through connected edges
                
                let direction: SWGVertexConnectionDirection
                let connectedVertexNumber: Int
                if endConnection.startVertexNumber == END_VERTEX_NUMBER {
                    direction = .Out
                    connectedVertexNumber = endConnection.endVertexNumber
                } else {
                    direction = .In
                    connectedVertexNumber = endConnection.startVertexNumber
                }
                
                let newConnection = SWGVertexConnection(direction: direction, connectedToVertex: connectedVertexNumber, connectionValue: endConnection.value)
                
                endConnections.append(newConnection)
            }
            
            let endVertex = SWGVertex(number: edge.endVertexNumber, connectedVertexes: endConnections)
            vertexes.append(endVertex)
            
        }
        
        
        
        return vertexes
    }
    
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
                        self.graphType = .Oriented
                    }
                    edgesMatrix[vertexIndex].append(vertexComponent)
                }
            }
            // Setting type if Oriented is not set during loop check
            if graphType == nil {
                graphType = .Unoriented
            }
        
        //// END
        
        // Edges matrix ready to process
        debugPrint(edgesMatrix)
        
        
        //// INITIALIZING EDGES AND ADDING THEM TO GRAPH
        
            for (edgeNumber,edgeData) in edgesMatrix.enumerated() {

                let newEdge: SWGEdge
                
                // Checking graph type, initializing edge with edge data
                if graphType == .Oriented {
                    let endVertex = (graphType == .Oriented ? edgeData.index(of: -1) : edgeData.index(of: 1))
                    let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex! + 1, number: edgeNumber + 1, value: nil)
                } else {
                    let endVertex = edgeData.index(of: 1)!
                    let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex + 1, number: edgeNumber + 1, value: nil)
                }
                
                self.graphEdges.append(newEdge)
                
            }
        
        //// END
        
        
    }
    
    
    //// Methods
    
    public func addEdge(start: Int, end: Int, value: Int?) {
        
        let edge = SWGEdge(edgeFor: self, start: start, end: end, number: graphEdges.count, value: value)
        self.graphEdges.append(edge)
        
    }
    
    public func removeLastEdge() {
        
        self.graphEdges.removeLast()
        
    }
    
    public func removeEdge(number: Int) {
        
        self.graphEdges.remove(at: number - 1)
        for edgeIndex in (number-1)..<graphEdges.count {
            graphEdges[edgeIndex].number -= 1
        }
        
    }
    
    
}
