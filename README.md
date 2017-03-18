

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
### Edges
Edges are initialized in graph internaly and must not be initialized manually.

#### Getting edges from graph
```swift
let edges = graph.edges // [SWGEdge]
```

#### Getting start and end vertexes numbers
```swift
let startIndex = edge.startVertexNumber // Int
```

#### Getting start and end connections
```swift
let startConnections = edge.startVertexConnections // [SWGEdge]
```

## Author

VihlayewAlex, vihlayew.alex@gmail.com

## License

SWGraphs is available under the MIT license. See the LICENSE file for more info.
