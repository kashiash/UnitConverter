//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jacek Placek on 10/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers

    @State var selectedUnits = 0
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Odległość","Masa","Temperatura","Czas","Objętość","Prędkość"]
    
//    let units: [UnitLength] = [.nanometers,.kilometers,.meters,.centimeters,.decameters,.nauticalMiles,.feet,.yards,.miles,.lightyears,.parsecs]
    
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles,UnitLength.parsecs,UnitLength.lightyears,UnitLength.nauticalMiles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds,UnitMass.carats],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds],
        [UnitVolume.liters, UnitVolume.bushels, UnitVolume.gallons,UnitVolume.imperialGallons,UnitVolume.pints],
        [UnitSpeed.knots,UnitSpeed.kilometersPerHour,UnitSpeed.metersPerSecond,UnitSpeed.milesPerHour]
    ]
    
    
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
                TextField("Ilość",value: $input, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
            } header : {
                Text("Wartość do konwersji")
            }
            
                Picker("Rodzaj", selection: $selectedUnits) {
                    ForEach(0..<conversions.count) {
                        Text(conversions[$0])
                    }
                }

                Picker("Konwersja z", selection: $inputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }

                Picker("Konwersja na", selection: $outputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                Button("Zamień"){
                    let oldOutputUnit = outputUnit
                    outputUnit = inputUnit
                    inputUnit = oldOutputUnit
                }
            Section{
                Text(result)
            } header: {
                Text("Wynik")
            }
        }
      
        .navigationTitle("Konwerter jednostek")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Dalej") {
                    inputIsFocused = false
                }
            }
       
        }
        .onChange(of: selectedUnits) { newSelection in
            let units = unitTypes[newSelection]
            inputUnit = units[0]
            outputUnit = units[1]
        }
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
