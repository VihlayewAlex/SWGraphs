//
//  ViewController.swift
//  SWGraphs
//
//  Created by VihlayewAlex on 03/16/2017.
//  Copyright (c) 2017 VihlayewAlex. All rights reserved.
//

import UIKit
import SWGraphs

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let matrix = [[1,1,-1,0,0,0,0,0],
                      [-1,0,0,1,0,1,0,0],
                      [0,-1,0,0,1,0,0,0],
                      [0,0,1,-1,-1,0,1,1],
                      [0,0,0,0,0,-1,-1,0]]
        
        let graph = SWGGraph(with: matrix)
//        graph.addEdge(start: 2, end: 3, value: nil)
        print(graph.edges)
        print("---")
//        graph.removeLastEdge()
//        print(graph.edges)
//        print("---")
//        graph.removeEdge(number: 1)
//        print(graph.edges)
//        print("---\n\n\n---")
//        print(graph.getSubvertexesNumbersForVertex(number: 1))
//        print(graph.getSubvertexesNumbersForVertex(number: 2))
//        print(graph.getSubvertexesNumbersForVertex(number: 3))
//        print(graph.getSubvertexesNumbersForVertex(number: 4))
//        print("---")
//        print(graph.lengthInGraph(from: 3, to: 4))
//        print(graph.getEccentricity(forVertex: 3))
//        print(graph.graphRadius)
//        print(graph.graphDiameter)
//        print(graph.centers)
//        print("---")
//        print(graph.vertexes.first!.isLeaf)
//        print(graph.vertexes[4].isSink)
//        print(graph.vertexes.first!.isSource)
//        print(graph.vertexes.first!.isIsolated)
//        print("DFS:")
//        print(graph.getDFSvertexes(fromVertex: 2))
//        print("DFS (simplified):")
//        print(graph.getDFSvertexes(fromVertex: 2).map({ $0.number }))
//        print("---------")
//        print("BFS:")
//        print(graph.getBFSvertexes(fromVertex: 2))
//        print("BFS (simplified):")
//        print(graph.getBFSvertexes(fromVertex: 2).map({ $0.number }))
        print("Lengths:")
        print(graph.getLengthsMatrix())
        print("---------")
        print("Availability:")
        print(graph.getAvailabilityMatrix())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

