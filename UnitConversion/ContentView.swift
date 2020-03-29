import SwiftUI

struct ContentView: View {
    
    let backgroundColor = LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
    
    @State private var inputNum = "0"
    @State private var inputUnit = 2
    @State private var outputUnit = 1
    let unit = ["second", "minute", "hour", "day"]
    let units = ["seconds", "minutes", "hours", "days"]
    
    var calculation: Double {
        //    外にある変数や定数を使うとエラーになるよ！
        //    だから中だけの変数作ってそれ使って計算しよう！
        let inputNumber = Double(Int(inputNum) ?? 0)
        let beforeUnit = units[inputUnit]
        let afterUnit = units[outputUnit]
        var beforeNum: Double = 0
        var afterNum: Double = 0
        
        switch beforeUnit {
        case "seconds":
            beforeNum = inputNumber
        case "minutes":
            beforeNum = inputNumber * 60
        case "hours":
            beforeNum = inputNumber * 3600
        case "days":
            beforeNum = inputNumber * 86400
        default:
            print("インプットエラー")
        }
        
        switch afterUnit {
        case "seconds":
            afterNum = beforeNum
        case "minutes":
            afterNum = beforeNum / 60
        case "hours":
            afterNum = beforeNum / 3600
        case "days":
            afterNum = beforeNum / 86400
        default:
            print("アウトプットエラー")
        }
        
        return afterNum
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Section (header: Text("1. Choose the input unit")){
                        Picker("Units", selection: $inputUnit) {
                            ForEach(0 ..< units.count) {
                                Text("\(self.units[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section (header: Text("2. Enter the number")){
                        TextField("Enter the number", text: $inputNum)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    
                    Section (header: Text("3. Choose the output unit")){
                        Picker("Units", selection: $outputUnit) {
                            ForEach(0 ..< units.count) {
                                Text("\(self.units[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Spacer()
                    
                    VStack{
                        Group{
                            if Int(inputNum) ?? 0 <= 1 {
                                //  1以下だったら単位の末尾からsを抜いて表示
                                Text("\(inputNum) \(unit[inputUnit])")
                            } else {
                                Text("\(inputNum) \(units[inputUnit])")
                            }
                        }.font(.largeTitle).frame(width: 300)
                        
                        Image(systemName: "arrow.up.arrow.down").padding().font(.largeTitle)
                        
                        Group{
                            if calculation <= 1 {
                                //  1以下だったら単位の末尾からsを抜いて表示
                                if calculation.truncatingRemainder(dividingBy: 1) == 0 {
                                    Text("\(calculation, specifier: "%g") \(unit[outputUnit])")
                                } else {
                                    Text("\(calculation, specifier: "%.3f") \(unit[outputUnit])")
                                }
                                
                            } else {
                                if calculation.truncatingRemainder(dividingBy: 1) == 0 {
                                    Text("\(calculation, specifier: "%g") \(units[outputUnit])")
                                } else {
                                    Text("\(calculation, specifier: "%.3f") \(units[outputUnit])")
                                }
                            }
                        }.font(.largeTitle).frame(width: 300)
                    }
                    
                    
                    Spacer()
                }
            }.navigationBarTitle("Time Conversion")
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
