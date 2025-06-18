//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Ruhi Jame on 6/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    //@State private var outputValue = 0.0
    @State private var inputUnits = "Celsius"
    @State private var outputUnits = "Celsius"
    @FocusState private var inputValueIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var celsiusValue: Double {
        var celsiusValue = 0.0
        
        switch inputUnits {
        case "Celsius":
            celsiusValue = inputValue
        case "Fahrenheit":
            celsiusValue = (inputValue - 32) * (5 / 9)
        case "Kelvin":
            celsiusValue = inputValue - 273.15
        default:
            return 0.0
        }
        
        return celsiusValue
    }
    
    var celsiusConverted: Double {
        var converted = 0.0
        
        switch outputUnits {
        case "Celsius":
            converted = celsiusValue
        case "Fahrenheit":
            converted = celsiusValue * (9 / 5) + 32
        case "Kelvin":
            converted = celsiusValue + 273.15
        default:
            return 0.0
        }
        
        return converted
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Input") {
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputValueIsFocused)
                    
                    Picker("Units", selection: $inputUnits) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Text(celsiusConverted, format: .number)

                    Picker("Units", selection: $outputUnits) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Convert Temperature")
            .toolbar {
                if (inputValueIsFocused) {
                    Button("Done") {
                        inputValueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
