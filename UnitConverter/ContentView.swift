//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jacek Placek on 10/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    let units: [UnitLength] = [.nanometers,.kilometers,.meters,.centimeters,.decameters,.nauticalMiles,.feet,.yards,.miles,.lightyears,.parsecs]
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView{
            Form{
            Section{
                TextField("Amount",value: $input, format: .number)
                    .keyboardType(.decimalPad)
            } header : {
                Text("Amount to convert")
            }
            
            Picker("Convert from",selection: $inputUnit){
                ForEach(units,id: \.self){
                    Text(formatter.string(from: $0).capitalized)
                }
            }
            
            Picker("Convert to",selection: $outputUnit){
                ForEach(units,id: \.self){
                    Text(formatter.string(from: $0).capitalized)
                }
            }
            Section{
                Text(result)
            } header: {
                Text("Result")
            }
        }
        .navigationTitle("Converter")
    }

    }
    init(){
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
        
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
