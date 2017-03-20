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
    
    public func lengthInGraph(from first_number: Int, to second_number: Int) -> Double {
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
        

        
        return W[first_index][second_index]
    }
    
    private var discoveredVertices = [SWGVertex]()
    public func getDFSvertexes(fromVertex number: Int) -> [SWGVertex] {
    
        discoveredVertices.removeAll()
    
        discoveredVertices.append(vertexes[number - 1])
        
        return DFS(fromVertex: number)

    }
    private func DFS(fromVertex number: Int) -> [SWGVertex] {
        
        for subvertex in getSubvertexesNumbersForVertex(number: number) {
            if !(discoveredVertices.map({ $0.number }).contains(subvertex)) {
                discoveredVertices.append(vertexes[subvertex - 1])
                _ = DFS(fromVertex: subvertex)
            }
        }
        
        return discoveredVertices
    }
    
    public func getBFSvertexes(fromVertex number: Int) -> [SWGVertex] {
        
        var queue = [SWGVertex]()
        var visited = [SWGVertex]()
        
        queue.append(vertexes[number - 1])
        visited.append(vertexes[number - 1])
        
        while !(queue.isEmpty) {
            
            let vertex = queue[0]
            queue.remove(at: 0)
            
            if visited.count == vertexes.count {
                return visited
            }
            
            if queue.count == 0 {
                for node in getSubvertexesNumbersForVertex(number: vertex.number) {
                    if !(visited.map({ $0.number }).contains(node)) && !(queue.map({ $0.number }).contains(node)) {
                        queue.append(vertexes[node - 1])
                        visited.append(vertexes[node - 1])
                    }
                }
            }
        }
        
        return visited
    }

   
    
    public func getEccentricity(forVertex number: Int) -> Double {
        
        var eccentricity = 0.0
        
        for vertex in 1...vertexes.count {
            if vertex != number {
                let newEcc = lengthInGraph(from: number, to: vertex)
                if newEcc > eccentricity {
                    eccentricity = newEcc
                }
            }
        }
        
        return eccentricity
    }
    
    public var graphDiameter: Double {
        
        var maxDiameter = 0.0
        
        for first_vertex_index in 0..<vertexes.count {
            for second_vertex_index in 0..<vertexes.count {
                let currentLength = lengthInGraph(from: first_vertex_index + 1, to: second_vertex_index + 1)
                if currentLength > maxDiameter {
                    maxDiameter = currentLength
                }
            }
        }
        
        return maxDiameter
    }
    
    public var graphRadius: Double {
        
        var radius = getEccentricity(forVertex: 1)
        
        for vertex in 1..<vertexes.count {
            radius = min(getEccentricity(forVertex: vertex), radius)
        }
        
        return radius
    }
    
    public var centers: [Int] {
        
        var centers = [Int]()
        
        for vertex in 1...vertexes.count {
            if getEccentricity(forVertex: vertex) == graphRadius {
                centers.append(vertex)
            }
        }
        
        return centers
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
                    if edgeData.filter({ $0 != 0 }).count == 1 {
                        let vertexIndex = edgeData.index(of: 1)! + 1
                        newEdge = SWGEdge(edgeFor: self, start: vertexIndex, end: vertexIndex, number: edgeNumber + 1, value: 1)
                    } else {
                        let endVertex = (graphType == .Oriented ? edgeData.index(of: -1) : edgeData.index(of: 1))
                        let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                        newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex! + 1, number: edgeNumber + 1, value: 1)
                    }
                } else {
                    if edgeData.filter({ $0 != 0 }).count == 1 {
                        let vertexIndex = edgeData.index(of: 2)
                        newEdge = SWGEdge(edgeFor: self, start: vertexIndex!, end: vertexIndex!, number: edgeNumber + 1, value: 1)
                    } else {
                        let endVertex = edgeData.index(of: 1)! + 1
                        let startVertex = Int(edgeData.count - 1 - edgeData.reversed().index(of: 1)!)
                        newEdge = SWGEdge(edgeFor: self, start: startVertex + 1, end: endVertex + 1, number: edgeNumber + 1, value: 1)
                    }
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
