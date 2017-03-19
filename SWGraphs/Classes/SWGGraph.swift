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
        
        var vertexesArr = [SWGVertex]()
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
            vertexesArr.append(startVertex)
            
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
            vertexesArr.append(endVertex)
            
        }
        
        var unique = Set<Int>()
        var uniqueVertexesArray = [SWGVertex]()
        for vertex in vertexesArr {
            if !(unique.contains(vertex.number)) {
                uniqueVertexesArray.append(vertex)
                unique.insert(vertex.number)
            }
        }
        uniqueVertexesArray.sort(by: { $0.number < $1.number })
        
        
        return uniqueVertexesArray
    }
    
    public func getSubvertexesNumbersForVertex(number: Int) -> [Int] {
        return (vertexes.filter({ $0.number == number })).first!.connectedVertexesNumbers
    }
    public func getConnectionsForVertex(number: Int) -> [SWGVertexConnection] {
        return (vertexes.filter({ $0.number == number })).first!.connectedVertexes
    }
    
    public func lengthInGraph(from first_number: Int, to second_number: Int) -> Int {
        // Defining indexes
        let first_index = first_number - 1
        let second_index = second_number - 1
        
        var W = [[Double]]()
        for _ in 0..<vertexes.count {
            var subarray = [Double]()
            for _ in 0..<vertexes.count {
                subarray.append(0)
            }
            W.append(subarray)
        }
        
        for i in 0..<vertexes.count {
            for j in 0..<vertexes.count {
                
                var intersection = false
                var value: Double = Double.infinity
                
                let connections = vertexes[i].connectedVertexesNumbers
                let destinationVertexNumber = vertexes[j].number
                
                
                    if connections.contains(destinationVertexNumber) {
                        intersection = true
                        value = vertexes[i].connectedVertexes.filter({ $0.connectedToVertex == destinationVertexNumber }).first!.connectionValue
                    }
                
                
                if intersection {
                    W[i][j] = value
                } else {
                    W[i][j] = Double.infinity
                }
                
            }
        }
        
        
        for k in 0..<vertexes.count {
            for i in 0..<vertexes.count {
                for j in 0..<vertexes.count {
                    W[i][j] = min(W[i][j], W[i][k] + W[k][j])
                }
            }
        }
        

        
        return Int(W[first_index][second_index])
    }
    
    
    
    
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
                    newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex! + 1, number: edgeNumber + 1, value: 1)
                } else {
                    let endVertex = edgeData.index(of: 1)!
                    let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                    newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex + 1, number: edgeNumber + 1, value: 1)
                }
                
                self.graphEdges.append(newEdge)
                
            }
        
        //// END
        
        
    }
    
    
    //// Methods
    
    public func addEdge(start: Int, end: Int, value: Double) {
        
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
