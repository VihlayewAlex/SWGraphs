//
//  SWGVertex.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/18/17.
//
//

import Foundation

public struct SWGVertex: CustomStringConvertible {
    
    public var description: String {
        return "SWGVertex(Number: \(self.number), Connections: [ \(self.connectedVertexes) ])"
    }
    
    public var number: Int
    public var connectedVertexes: [SWGVertexConnection]
    public var connectedVertexesNumbers: [Int] {
        return connectedVertexes.map{ $0.connectedToVertex }
    }
}

public enum SWGVertexConnectionDirection {
    case In
    case Out
}
public struct SWGVertexConnection: CustomStringConvertible {
    
    public var description: String {
        return "(\(self.direction) connection to \(self.connectedToVertex) with value \(self.connectionValue))"
    }
    
    public var direction: SWGVertexConnectionDirection
    public var connectedToVertex: Int
    public var connectionValue: Double
}
