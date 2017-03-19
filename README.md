

![logo](https://cloud.githubusercontent.com/assets/22377058/24007440/388ef8d0-0a77-11e7-8419-ac21789b792e.png)



[![CI Status](http://img.shields.io/travis/VihlayewAlex/SWGraphs.svg?style=flat)](https://travis-ci.org/VihlayewAlex/SWGraphs)
[![Version](https://img.shields.io/cocoapods/v/SWGraphs.svg?style=flat)](http://cocoapods.org/pods/SWGraphs)
[![License](https://img.shields.io/cocoapods/l/SWGraphs.svg?style=flat)](http://cocoapods.org/pods/SWGraphs)
[![Platform](https://img.shields.io/cocoapods/p/SWGraphs.svg?style=flat)](http://cocoapods.org/pods/SWGraphs)

SWGraphs is a graph data structure, operations and algorithms library, written with Swift.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

SWGraph requires Swift 3 support. (Xcode 8+)

## Installation

SWGraphs is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SWGraphs"
```

## Usage

### Import
Don't forget to add import:
```swift
import SWGraphs
```

### Graphs

#### Initializing with incidence matrix
More about incidence matrixes on [Wikipedia](https://en.wikipedia.org/wiki/Incidence_matrix).
```swift
let incidenceMatrix = [ [1,0,-1,1],
                        [-1,1,0,0],
                        [0,-1,1,0],
                        [0,0,0,-1] ]
let graph = SWGGraph(with: incidenceMatrix)
```
#### Graph types
Every graph have it's type, defined as `SWGGraphType`:
```swift
public enum SWGGraphType {
    case Oriented
    case Unoriented
}
```
Notice that type is get-only property so it can not be changed manually.

### Edges
Edges are initialized in graph internaly and must not be initialized manually.

#### Operations with edges 

Getting edges from graph:
```swift
let edges = graph.edges // [SWGEdge]
```
Like a graph types, edges age get-only and can be modified only with functions listed below:

Adding edges to graph:
```swift
graph.addEdge(start: 2, end: 3, value: nil) // Adds edge from vertex 2 to 3
graph.addEdge(start: 16, end: 7, value: 13) // Adds edge from vertex 16 to 7 with value of 13
```

Removing edges from graph:
```swift
graph.removeEdge(at: 3) // Removes edge with number 3
graph.removeLastEdge() // Removes last edge
```

#### Getting edge's vertices and connections

Getting start and end vertices numbers:
```swift
let startIndex = edge.startVertexNumber // Int
let endIndex = edge.endVertexNumber // Int
```

Getting start and end connections:
```swift
let startConnections = edge.startVertexConnections // [SWGEdge]
let endConnections = edge.endVertexConnections // [SWGEdge]
```

### Vertices
Getting vertices from graph:
```swift
let vertices = graph.vertexes // [SWGVertex]
```

Vertex is represented by `SWGVertex`:
```swift
public struct SWGVertex: CustomStringConvertible {
    
    public var description: String {
        return "SWGVertex(Number: \(self.number), Connections: [ \(self.connectedVertexes) ])"
    }
    
    public var number: Int
    public var connectedVertexes: [SWGVertexConnection]
}
```

Vertexe's `connectedVertexes` are represented by array of `SWGVertexConnection`:
```swift
public struct SWGVertexConnection: CustomStringConvertible {
    
    public var description: String {
        return "(\(self.direction) connection to \(self.connectedToVertex) with value \(self.connectionValue))"
    }
    
    public var direction: SWGVertexConnectionDirection
    public var connectedToVertex: Int
    public var connectionValue: Int?
}
```

Connection's direction is of type `SWGVertexConnectionDirection`:
```swift
public enum SWGVertexConnectionDirection {
    case In
    case Out
}
```

Getting distance between two vertices:
```swift
graph.lengthInGraph(from: 3, to: 4) // Double
```

Getting vertex eccentricity:
```swift
graph.getEccentricity(forVertex: 3) // Double
```

## Author

VihlayewAlex, vihlayew.alex@gmail.com

## License

SWGraphs is available under the MIT license. See the LICENSE file for more info.
