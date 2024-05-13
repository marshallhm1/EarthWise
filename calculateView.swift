import ARKit
import SwiftUI
import RealityKit
import WebKit
import SceneKit





struct ContentView: View {
    // Declare Carbon Footprint
    @State private var carbonFootprint = 0.0
    // Track tabs
    @State private var selectedTab: Int = 0
    
    // Declare flags to track
    @State private var elecBillFlag = false
    @State private var gasBillFlag = false
    @State private var milesFlag = false
    @State private var shortFlag = false
    @State private var longFlag = false
    
    var body: some View {
        // TabView for pages
        TabView(selection: $selectedTab){
            ClimateChangeInfo()
                .tabItem {
                    EmptyView()
                }
                .tag(0)
            
            CarbonFootprintCalculator(carbonFootprint: $carbonFootprint, selectedTab: $selectedTab, elecBillFlag: $elecBillFlag, gasBillFlag: $gasBillFlag, milesFlag: $milesFlag, shortFlag: $shortFlag, longFlag: $longFlag)
                .tabItem {
                    EmptyView()
                }
                .tag(1)
            
            // Do not show ResultsView until user has calculated carbon footprint
            if (carbonFootprint > 0){
                ResultsView(elecBillFlag: $elecBillFlag, gasBillFlag: $gasBillFlag, milesFlag: $milesFlag, shortFlag: $shortFlag, longFlag: $longFlag, carbonFootprint: carbonFootprint)
                    .tabItem {
                        EmptyView()
                    }
                    .tag(2)
            }
            
            /*
            // Do not show ARView until user has calculated carbon footprint
            if (carbonFootprint > 0){
                CustomARViewRepresentable(carbonFootprint: carbonFootprint)
                    .tabItem {
                        EmptyView()
                    }
                    .tag(3)
            }
            */
            
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color.black)
    }
}



// ResultsView Struct
struct ResultsView: View {
    // Pass var's to track high flags
    @Binding var elecBillFlag: Bool
    @Binding var gasBillFlag: Bool
    @Binding var milesFlag: Bool
    @Binding var shortFlag: Bool
    @Binding var longFlag: Bool
    
    var carbonFootprint: Double
    
    // Format carbon footprint output
    var formattedCarbonFootprint: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: carbonFootprint)) ?? ""
    }
        
    // Control personalized recommendations based on high values
    var centralText: String {
        var text = ""
        
        if elecBillFlag || gasBillFlag || milesFlag || shortFlag || longFlag {
            text = "Based on your inputs, here are some suggestions to lower your carbon footprint:\n\n"
        }
        
        if elecBillFlag {
            text += "\u{2022} Your electricity bill is higher than average. Consider reducing energy usage to lower your carbon footprint. \n\n"
        }
        if gasBillFlag {
            text += "\u{2022} Your gas bill is higher than average. Consider reducing usage to lower your carbon footprint. \n\n"
        }
        if milesFlag {
            text += "\u{2022} Your yearly mileage is higher than average. Consider using alternative transportation methods to lower your carbon footprint. \n\n"
        }
        if shortFlag {
            text += "\u{2022} You've taken more short flights than average. Consider reducing air travel to lower your carbon footprint. \n\n"
        }
        if longFlag {
            text += "\u{2022} You've taken more long flights than average. Consider reducing air travel to lower your carbon footprint. \n\n"
        }
        
        // If none of the flags are triggered, provide a default message
        if text.isEmpty {
            text = "Here are some general strategies to lower your carbon footprint:\n\n"
            text += "\u{2022} Use energy-efficient appliances and lights.\n\n"
            text += "\u{2022} Reduce, reuse, and recycle.\n\n"
            text += "\u{2022} Use public transportation, bike, or walk whenever possible.\n\n"
        }
        
        return text
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 10)
                // Display the calculated carbon footprint
                Text("Your carbon footprint is \(formattedCarbonFootprint).")
                    .font(.custom("Helvetica-Bold", size: 34))
                    .foregroundColor(.white)
                    .padding(15)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 20)
                
                // Very low output
                if carbonFootprint <= 5999 {
                    Text("This is considered very low. Keep up the good work!")
                        .font(.custom("Helvetica-Neue", size: 22))
                        .foregroundColor(.white)
                        .padding(20)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        // Happy Face and Green Earth for Low footprint
                        Image(systemName: "face.smiling.inverse")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                    }
                } 
                // Low or ideal impact
                else if carbonFootprint <= 15999 {
                    Text("This is considered low or ideal. You're making a positive impact!")
                        .font(.custom("Helvetica-Neue", size: 22))
                        .foregroundColor(.white)
                        .padding(20)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        // Happy Face and Green Earth for Low footprint
                        Image("face.smiling.inverse")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                    }
                    
                }   
                // Average impact
                else if carbonFootprint <= 22000 {
                    Text("This is considered average. There's room for improvement!")
                        .font(.custom("Helvetica-Neue", size: 22))
                        .foregroundColor(.white)
                        .padding(20)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        // Sad Face and Red Earth for Average footprint
                        Image("custom.face.sad.inverse")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                    }
                    
                }   
                // High impact
                else if carbonFootprint >= 22001 {
                    VStack {
                        Text("This is considered high. Consider reducing your carbon emissions.")
                            .font(.custom("Helvetica-Neue", size: 22))
                            .foregroundColor(.white)
                            .padding(20)
                            .multilineTextAlignment(.center)
                        HStack{
                            // Sad Face and Red Earth for High footprint
                            Image("custom.face.sad.inverse")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Image(systemName: "globe.americas.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.red)
                        }
                    }
                }
                
                
        
                                
                Spacer(minLength: 30)
                
                // Display personalized feedback
                Text(centralText)
                    .font(.custom("Helvetica-Neue", size: 22))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 2)
                    .multilineTextAlignment(.center)
                
                
                // Prep user for AR Scene
                Text("The next view will provide a visual representation of your carbon footprint using augmented reality. In this representation, each sphere represents 1 ton of carbon output, presented next to the iconic Empire State Building, the Burj Khalifa, and the One World Trade Center (but 99.996% smaller!) While this is an approximation, it offers a convenient way to visualize your impact on our planet! 🌍")
                    .font(.custom("Helvetica-Neue", size: 20))
                    .foregroundColor(.white)
                    .padding(10)
                    .multilineTextAlignment(.center)
                
                // Swipe to view AR Scene
                Text("Swipe right to visualize your carbon footprint.\(Image(systemName: "arrow.right"))")
                    .font(.custom("Helvetica-Oblique", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 30)
            }
        }
    }
}




// First page struct
struct ClimateChangeInfo: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Spacer(minLength: 10)
                    
                    Text("EarthWise")
                        .font(.custom("Helvetica-Bold", size: 38))
                        .foregroundColor(.white)
                        .padding(10)
                        .multilineTextAlignment(.center)
                    
                    Text("dedicated to improving the health of our planet")
                        .font(.custom("Helvetica-Oblique", size: 12))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer(minLength: 20)
                }
                
                Spacer(minLength: 75)
                
                // Created by Elf Pavlik under Creative Commons CC0 1.0 Universal Public Domain Dedication.
                // Use WebView to display Earth gif
                WebView(urlString: "earth_rotating.gif")
                    .frame(width: 310, height: 240)
                
                
                Text("Climate change refers to long-term changes in average weather patterns across Earth's global and local climates. It includes a wide range of phenomena, including changes in precipitation patterns, increases in temperatures, and more frequent extreme weather events, such as hurricanes, tornadoes, heat waves, and droughts. Climate change is primarily caused by human activities such as burning fossil fuels like coal, oil, and natural gas. The burning of these fuels releases greenhouse gases such as carbon dioxide (CO2) and methane (CH4) into the atmosphere. Global warming occurs as a result of these gases trapping heat in the atmosphere, causing the Earth's surface to gradually warm.")
                        .font(.custom("Helvetica-Neue", size: 22))
                        .foregroundColor(.white)
                        .padding(25)
                        .multilineTextAlignment(.leading)
                
                // Created by NASA under Public domain
                // Use WebView to display heat change gif
                WebView(urlString: "heat_change.gif")
                    .frame(width: 300, height: 166)
                    .aspectRatio(contentMode: .fit)
                
                
                Text("The effects of climate change are far-reaching on ecosystems, biodiversity, water resources, agriculture, and human societies. Climate change can be addressed by reducing greenhouse gas emissions, switching to renewable energy sources, and adapting to already existing changes. Typically expressed in metric tons of CO2e per year, carbon footprints measure the total amount of greenhouse gases emitted directly or indirectly by human activities over a given period of time. This includes emissions from sources such as energy production, transportation, industrial processes, agriculture, and waste management. To combat climate change and promote sustainability, we must understand and reduce our carbon footprint.")
                        .font(.custom("Helvetica-Neue", size: 22))
                        .foregroundColor(.white)
                        .padding(25)
                        .multilineTextAlignment(.leading)
                
                // Downloaded from IMGUR, used for non-commercial purposes
                // Use WebView to display earthrise gif
                WebView(urlString: "earthrise.gif")
                    .frame(width: 348, height: 195)
                
                Text("This is the first image ever taken of Earth from the moon; it led to the creation of Earth day, and propelled the environmental movement.")
                        .font(.custom("Helvetica-Oblique", size: 12))
                        .foregroundColor(.white)
                        .padding(0)
                        .multilineTextAlignment(.center)
                
                Spacer(minLength: 20)
                
                Text("Swipe right to calculate your carbon footprint.\(Image(systemName: "arrow.right"))")
                    .font(.custom("Helvetica-Oblique", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 60)
                
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("Climate Change Info")
        .background(Color.black)
    }
}


// WebView to load local GIF or video file
struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = Bundle.main.url(forResource: urlString, withExtension: nil) {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
}


// Calculator struct
struct CarbonFootprintCalculator: View {
    // Pass in vars
    @Binding var carbonFootprint: Double
    @Binding var selectedTab: Int
    
    // Flags passed
    @Binding var elecBillFlag: Bool
    @Binding var gasBillFlag: Bool
    @Binding var milesFlag: Bool
    @Binding var shortFlag: Bool
    @Binding var longFlag: Bool
    
    @State private var showPopup = false
    @State private var calc = false
    
    // Average values
    @State private var elecBill = 120.0
    @State private var gasBill = 80.0
    @State private var oilBill = 0.0
    @State private var carMileage = 13000.0
    @State private var flightsShort = 1.0
    @State private var flightsLong = 1.0
    @State private var recycleNewspaper = false
    @State private var recycleAluminum = false
    
    // isEditing to control slider functionality
    @State private var isEditing = false
    @State private var isEditingElecBill = false
    @State private var isEditingGasBill = false
    @State private var isEditingOilBill = false
    @State private var isEditingCarMileage = false
    @State private var isEditingShortFlights = false
    @State private var isEditingLongFlights = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Spacer(minLength: 10)
                    
                    Text("Calculate your carbon footprint.")
                        .font(.custom("Helvetica-Bold", size: 38))
                        .foregroundColor(.white)
                        .padding(10)
                        .multilineTextAlignment(.center)
                    
                    Text("If you are not sure of a value, please leave it blank, and an average value will be used.")
                        .font(.custom("Helvetica-Oblique", size: 12))
                        .foregroundColor(.white)
                        .padding(0)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                Spacer(minLength: 70)
                
                VStack(alignment: .leading) {
                    // Monthly Electric Bill
                    HStack{
                        Text("How much is your monthly home electricity bill per month, on average? \(Image(systemName: "bolt.circle"))")
                            .font(.custom("Helvetica-Neue", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    HStack{
                        Slider (
                            value: $elecBill,
                            in: 0...250,
                            step: 5,
                            onEditingChanged: { editing in
                                isEditingElecBill = editing
                                if $elecBill.wrappedValue > 160 {
                                    elecBillFlag = true
                                    print("Setting elecBillFlag to true")
                                } else {
                                    elecBillFlag = false
                                }
                            }
                        )
                        .accentColor(.white)
                        .frame(width:280, height:20)
                        Text(String(format: "%.0f", round(elecBill)))
                            .font(.custom("Helvetica-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Monthly Gas Bill
                    HStack{
                        Text("How much is your monthly home natural gas bill per month, on average? \(Image(systemName: "heater.vertical"))")
                            .font(.custom("Helvetica-Neue", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    HStack{
                        Slider (
                            value: $gasBill,
                            in: 0...160,
                            step: 5,
                            onEditingChanged: { editing in
                                isEditingGasBill = editing
                                if $gasBill.wrappedValue > 120 {
                                    gasBillFlag = true
                                    print("Setting elecBillFlag to true")
                                } else {
                                    gasBillFlag = false
                                }
                            }
                        )
                        .accentColor(.white)
                        .frame(width:280, height:20)
                        Text(String(format: "%.0f", round(gasBill)))
                            .font(.custom("Helvetica-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Total Yearly Mileage
                    HStack{
                        Text("How many miles do you drive per year? \(Image(systemName: "car"))")
                            .font(.custom("Helvetica-Neue", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    HStack{
                        Slider (
                            value: $carMileage,
                            in: 0...20000,
                            step: 500,
                            onEditingChanged: { editing in
                                isEditingCarMileage = editing
                                if $gasBill.wrappedValue > 16000 {
                                    gasBillFlag = true
                                    print("Setting elecBillFlag to true")
                                } else {
                                    gasBillFlag = false
                                }
                            }
                        )
                        .accentColor(.white)
                        .frame(width:280, height:20)
                        Text(String(format: "%.0f", round(carMileage)))
                            .font(.custom("Helvetica-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Short flights
                    HStack{
                        Text("How many flights have you taken in the past year (4 hours or less)? \(Image(systemName: "airplane.departure"))")
                            .font(.custom("Helvetica-Neue", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    HStack{
                        Slider (
                            value: $flightsShort,
                            in: 0...5,
                            step: 1,
                            onEditingChanged: { editing in
                                isEditingShortFlights = editing
                                if $flightsShort.wrappedValue > 3 {
                                    shortFlag = true
                                    print("Setting elecBillFlag to true")
                                } else {
                                    shortFlag = false
                                }
                            }
                        )
                        .accentColor(.white)
                        .frame(width:280, height:20)
                        Text(String(format: "%.0f", round(flightsShort)))
                            .font(.custom("Helvetica-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Long flights
                    HStack{
                        Text("How many flights have you taken in the past year (4 hours or more)? \(Image(systemName: "airplane.arrival"))")
                            .font(.custom("Helvetica-Neue", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    HStack{
                        Slider (
                            value: $flightsLong,
                            in: 0...5,
                            step: 1,
                            onEditingChanged: { editing in
                                isEditingLongFlights = editing
                                if $flightsLong.wrappedValue > 3 {
                                    longFlag = true
                                    print("Setting elecBillFlag to true")
                                } else {
                                    longFlag = false
                                }
                            }
                        )
                        .accentColor(.white)
                        .frame(width:280, height:20)
                        Text(String(format: "%.0f", round(flightsLong)))
                            .font(.custom("Helvetica-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 40)
                }
                
                HStack{
                    // Recycling Questions
                    Text("Do you recycle newspaper?")
                        .font(.custom("Helvetica-Neue", size: 20))
                        .padding(.horizontal, 5)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Toggle(isOn: $recycleNewspaper) {}
                }
                
                Spacer(minLength: 30)
                
                HStack{
                    Text("Do you recycle aluminum or tin?")
                        .font(.custom("Helvetica-Neue", size: 20))
                        .padding(.horizontal, 5)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Toggle(isOn: $recycleAluminum) {}
                }
                
                Spacer(minLength: 50)
                
                VStack {
                    // Button to calculate footprint
                    Button(action: {
                        calculateCarbonFootprint()
                        selectedTab = 2
                    }) {
                        Text("Calculate")
                            .font(.custom("Helvetica-Bold", size: 24))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                }
                
                Spacer(minLength: 80)
            }
            .padding(.horizontal, 20)
        }
    }
    
    func calculateCarbonFootprint() {
        carbonFootprint = (elecBill * 105) + (gasBill * 105) + (oilBill * 113) + (carMileage * 0.79) + (flightsShort * 1100) + (flightsLong * 4400)
        
        if !recycleNewspaper {
            carbonFootprint += 184
        }
        
        if !recycleAluminum {
            carbonFootprint += 166
        }
        
        // Normalize value
        carbonFootprint = carbonFootprint / 1.7
    }
}





