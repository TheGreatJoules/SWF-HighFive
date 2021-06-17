//
//  Chart.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 3/2/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import Foundation
import SwiftChart

class setupChart{
    
    static func newChart(chart: Chart){
        color()
        chart.add(LEVEL_CONSTANT.series0)
        chart.add(LEVEL_CONSTANT.series2)
        chart.add(LEVEL_CONSTANT.series4)
        chart.add(LEVEL_CONSTANT.series6)
        chart.add(LEVEL_CONSTANT.series8)
        chart.add(LEVEL_CONSTANT.series10)
        chart.add(LEVEL_CONSTANT.series12)
        chart.add(LEVEL_CONSTANT.series14)
        
        // MIN AND MAX RANGE
        chart.minY = 0
        chart.maxY = 14
        
        // BACKGROUND COLOR
        chart.backgroundColor = UIColor.white
        
        // TOUCH INTERACTION
        chart.isUserInteractionEnabled = false
        
        // TAG
        chart.tag = 100
        
        
    }
    static func color(){
        LEVEL_CONSTANT.series0.color = UIColor.red
        LEVEL_CONSTANT.series2.color = UIColor.orange
        LEVEL_CONSTANT.series4.color = UIColor.yellow
        LEVEL_CONSTANT.series6.color = UIColor.green
        LEVEL_CONSTANT.series8.color = UIColor.cyan
        LEVEL_CONSTANT.series10.color = UIColor.magenta
        LEVEL_CONSTANT.series12.color = UIColor.purple
        LEVEL_CONSTANT.series14.color = UIColor.blue
        
    }
    
    struct LEVEL_CONSTANT{
        static var series0 = ChartSeries([0, 0, 0, 0, 0, 0, 0, 0, 0])
        static var series2 = ChartSeries([2, 2, 2, 2, 2, 2, 2, 2, 2])
        static let series4 = ChartSeries([4, 4, 4, 4, 4, 4, 4, 4, 4])
        static let series6 = ChartSeries([6, 6, 6, 6, 6, 6, 6, 6, 6])
        static let series8 = ChartSeries([8, 8, 8, 8, 8, 8, 8, 8, 8])
        static let series10 = ChartSeries([10, 10, 10, 10, 10, 10, 10, 10, 10])
        static let series12 = ChartSeries([12, 12, 12, 12, 12, 12, 12, 12, 12])
        static let series14 = ChartSeries([14, 14, 14, 14, 14, 14, 14, 14, 14])
        
    }
}
