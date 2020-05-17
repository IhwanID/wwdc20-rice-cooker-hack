import PlaygroundSupport
import SwiftUI
import AVFoundation

struct ContentView: View{
    
    @State var ingredients: [String] = ["rice","noodle", "egg", "kale", "margarine", "tomato", "macaroni", "water", "jelly", "seasoning", "ketchup","milk"]
    @State var selections: [String] = []
    
    @State private var showingAlert = false
    @State private var isAudio = false
    @State private var result: String? = nil
    @State private var isCorrect = false
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("RiceCooker Hack").font(.largeTitle).padding(.top, 100).foregroundColor(Color.white)
                
                Button(action: {
                    
                    if Sounds.player?.isPlaying == true{
                        Sounds.player?.stop()
                       }else {
                           Sounds.playBackSound(soundfile: "Goat.mp3")
                       }
                    self.isAudio.toggle()
                }){
                    Image(uiImage: UIImage(named: isAudio ? "soundon.png" : "soundoff.png")!).renderingMode(.original)
                        .resizable().frame(width: 40,height: 40)
                        .aspectRatio(contentMode: .fit)
                }.padding(.vertical, 20)
                
                
                GridStack(rows: 3, columns: 4) { row, col in
                    CardView(name: self.ingredients[row * 4 + col], isSelected: self.selections.contains(self.ingredients[row * 4 + col])){
                        if self.selections.contains(self.ingredients[row * 4 + col]) {
                            self.selections.removeAll(where: { $0 == self.ingredients[row * 4 + col] })
                            Sounds.playSounds(soundfile: "click.mp3")
                            
                        }
                        else {
                            self.selections.append(self.ingredients[row * 4 + col])
                            Sounds.playSounds(soundfile: "click.mp3")
                        }
                    }
                }
                
                Button(action: {
                    let nasgor = ["egg","margarine","rice", "seasoning"]
                    let rice = ["rice","water"]
                    let omelet = ["margarine", "egg", "seasoning"]
                    let sautedKale = ["seasoning", "kale", "margarine"]
                    let jelly = ["jelly","water"]
                    let macharoni = ["macaroni", "seasoning", "water"]
                    let ramen = ["noodle", "egg", "water", "seasoning"]
                    
                    if self.selections.count < 2{
                        Sounds.playSounds(soundfile: "fail.mp3")
                    }else{
                        if self.selections.containsSameElements(as: nasgor) {
                            Sounds.playSounds(soundfile: "kids.mp3")
                            self.isCorrect = true
                            self.result = "nasi goreng"
                        }else if self.selections.allSatisfy(rice.contains){
                            self.isCorrect = true
                            self.result = "rice"
                            Sounds.playSounds(soundfile: "kids.mp3")
                            
                        }else if self.selections.allSatisfy(omelet.contains){
                            self.isCorrect = true
                            self.result = "Omelet"
                            Sounds.playSounds(soundfile: "kids.mp3")
                            
                        }else if self.selections.allSatisfy(sautedKale.contains){
                            self.isCorrect = true
                            self.result = "Sauted Kale"
                            Sounds.playSounds(soundfile: "kids.mp3")
                            
                        }else if self.selections.allSatisfy(jelly.contains){
                            self.isCorrect = true
                            self.result = "Jelly"
                            Sounds.playSounds(soundfile: "kids.mp3")
                        }else if self.selections.allSatisfy(macharoni.contains){
                            self.isCorrect = true
                            self.result = "Macharoni"
                            Sounds.playSounds(soundfile: "kids.mp3")
                        }else if self.selections.containsSameElements(as: ramen){
                            self.isCorrect = true
                            self.result = "ramen"
                            Sounds.playSounds(soundfile: "kids.mp3")
                        }else {
                            self.result = "belum beruntung"
                            self.isCorrect = false
                            Sounds.playSounds(soundfile: "fail.mp3")
                        }
                    }
                    
                    self.showingAlert = true
                    self.selections.removeAll()
                }){
                    HStack {
                        Image(uiImage: UIImage(named: "ricecooker.png")!).renderingMode(.original)
                            .resizable().frame(width: 40,height: 40)
                            .aspectRatio(contentMode: .fit)
                        Text("cook")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(width: 250,height: 40)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(40)
                    .padding(.bottom, 20)
                    
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text(self.isCorrect ? "Yaaaay!" : "Naaah!"), message: Text(self.isCorrect ? "Your \(self.result ?? "") 🍲 is ready to serve" : "☹️ I dont think those are good combination"), dismissButton: .default(Text(self.isCorrect ? "Okay!" : "Try Again!")))
                }.padding(.top, 30)
                
                
                
            }.edgesIgnoringSafeArea(.top)
            
            
        }
            
        .navigationBarBackButtonHidden(true)
    }
}

struct IntroScreen: View {
    var body: some View {
        
        NavigationView {
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    Text("RiceCooker Hack").font(.title).padding(.vertical, 30).foregroundColor(Color.white)
                    
                    Image(uiImage: UIImage(named: "ricecooker.png")!).renderingMode(.original)
                        .resizable().frame(width: 100,height: 100)
                        .aspectRatio(contentMode: .fit).padding(.vertical, 20)
                    
                    
                    Text("Choose THE RIGHT INGREDIENTS \n to create  super easy meals you can make \n in a rice cooker").padding(.bottom, 20).multilineTextAlignment(.center).foregroundColor(Color.white).padding(.horizontal, 10)
                    
                    
                    NavigationLink(destination: ContentView()) {
                        
                        Text("LET'S COOK!")
                            .frame(width: 250,height: 20)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(40)
                            .padding(.vertical, 20)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            
            
        }
        
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}


class Sounds {
    static var audioPlayer:AVAudioPlayer?
    static var player:AVAudioPlayer?
    
    static func playSounds(soundfile: String) {
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            }catch{
                print("Error")
            }
        }
    }
    
    static func playBackSound(soundfile: String){
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.numberOfLoops = -1
                player?.play()
            } catch {
                print("Error")
            }
        }
        
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
                
            }
            
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}




struct CardView: View {
    
    var name: String
    var isSelected: Bool = false
    var action: () -> Void
    
    var body: some View {
        
        VStack{
            Button(action: self.action){
                Image(uiImage: UIImage(named: "\(name).jpg")!).renderingMode(.original)
                    .resizable().frame(width: 65,height: 65)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all, 5)
            }
            .background(Color.white)
            .border(isSelected ? Color.purple: Color.white, width: 2)
            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
            .rotation3DEffect(self.isSelected ? Angle(degrees: 360): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            .animation(.default)
            Text(name).font(.system(size: 12, weight: .heavy, design: .default)).padding(.top, 2).foregroundColor(isSelected ? Color.purple: Color.white)
            
        }
        
    }
}


PlaygroundPage.current.setLiveView(IntroScreen())
