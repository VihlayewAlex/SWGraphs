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
    
    var number: Int
    var connectedVertexes: [SWGVertexConnection]
}
public enum SWGVertexConnectionDirection {
    case In
    case Out
}
struct SWGVertexConnection: CustomStringConvertible {
    
    public var description: String {
        return "(\(self.direction) connection to \(self.connectedToVertex) with value \(self.connectionValue))"
    }
    
    var direction: SWGVertexConnectionDirection
    var connectedToVertex: Int
    var connectionValue: Int?
}
