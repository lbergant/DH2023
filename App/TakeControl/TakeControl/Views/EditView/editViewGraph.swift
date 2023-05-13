//
//  editViewGraph.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct editViewGraph: View {
    @State private var dataPoints: [CGFloat] = [0.2, 0.7, 0.3, 0.9, 0.1, 0.6, 0.4]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in dataPoints.indices {
                    let xPosition = geometry.size.width / CGFloat(dataPoints.count) * CGFloat(index)
                    let yPosition = geometry.size.height * (1 - dataPoints[index])
                    
                    let point = CGPoint(x: xPosition, y: yPosition)
                    
                    if index == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}


struct editViewGraph_Previews: PreviewProvider {
    static var previews: some View {
        editViewGraph()
    }
}
