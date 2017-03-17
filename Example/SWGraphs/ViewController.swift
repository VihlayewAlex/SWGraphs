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
        
        let testVertex1 = SWGVertex(name: "first", number: 1, connectedEdges: [])
        let testVertex2 = SWGVertex(name: "first", number: 1, connectedEdges: [])
        
        let testEdge = SWGEdge(start: testVertex1, end: testVertex2, value: 3)
        
        let graph = SWGGraph(type: .Oriented, vertices: [testVertex1,testVertex2], edges: [testEdge])
        print(graph)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

