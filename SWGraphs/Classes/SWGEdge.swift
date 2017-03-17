//
//  SWGEdge.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/16/17.
//
//

import UIKit

public class SWGEdge {
    
    public var startVertex: SWGVertex
    public var endVertex: SWGVertex
    
    public var value: Int?
    
    public init(start: SWGVertex, end: SWGVertex, value: Int?) {
        
        self.startVertex = start
        self.endVertex = end
        
        self.value = value
        
    }
    
}
