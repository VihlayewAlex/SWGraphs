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
        
        let matrix = [[1,0,-1,1],[-1,1,0,0],[0,-1,1,0],[0,0,0,-1]]
        
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
        print(graph.getSubvertexesNumbersForVertex(number: 1))
        print(graph.getSubvertexesNumbersForVertex(number: 2))
        print(graph.getSubvertexesNumbersForVertex(number: 3))
        print(graph.getSubvertexesNumbersForVertex(number: 4))
        print("---")
        print(graph.lengthInGraph(from: 3, to: 4))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

