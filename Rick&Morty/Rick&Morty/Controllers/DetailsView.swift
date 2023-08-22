import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode

    let cardImage: Image
    let cardText: String
    let character: Character
    
    var body: some View {
        NavigationView {
            ScrollView{
                ZStack { // Use a ZStack as the root view
                    Color(red: 0.02, green: 0.05, blue: 0.12) // Set the background color
                    
                    VStack(spacing: 16) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 148, height: 148)
                            .background(
                                cardImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 148, height: 148)
                                    .clipped()
                            )
                            .cornerRadius(16)
                        
                        // Character Name
                        Text(cardText)
                            .font(
                                Font.custom("Gilroy", size: 22)
                                    .weight(.bold)
                            )
                            .kerning(0.32)
                            .foregroundColor(.white)
                        
                        // Body Default
                        Text(character.status)
                            .font(
                                Font.custom("Gilroy", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(character.status == "Alive" ? Color(red: 0.28, green: 0.77, blue: 0.04) : Color(red: 0.72, green: 0.00, blue: 0.00))
                        
                        // Info
                        Text("Info")
                            .font(
                                Font.custom("Gilroy", size: 17)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 327, height: 124)
                                .background(Color(red: 0.15, green: 0.16, blue: 0.22))
                                .cornerRadius(16)
                            VStack{
                                //Species
                                HStack(){
                                    Text("Species:")
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                                        .frame(width: 64.9201, alignment: .leading)
                                        .padding(.leading, 44)
                                    
                                    Spacer()
                                    
                                    Text(character.species)
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.white)
                                        .frame(alignment: .trailing)
                                        .padding(.trailing, 44)
                                    
                                }
                                
                                //Type
                                HStack(){
                                    Text("Type:")
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                                        .frame(alignment: .leading)
                                        .padding(.leading, 44)
                                    
                                    Spacer()
                                    
                                    Text(character.type == "" ? "None" : character.type)
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.white)
                                        .frame(alignment: .trailing)
                                        .padding(.trailing, 44)
                                    
                                }
                                
                                //Gender
                                HStack(){
                                    // Body Default
                                    Text("Gender:")
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.77, green: 0.79, blue: 0.81))
                                        .frame(alignment: .leading)
                                        .padding(.leading, 44)
                                    
                                    Spacer()
                                    
                                    Text(character.gender)
                                        .font(
                                            Font.custom("Gilroy", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.white)
                                        .frame(alignment: .trailing)
                                        .padding(.trailing, 44)
                                }
                            }
                        }
                        
                        // Origin
                        Text("Origin")
                            .font(
                                Font.custom("Gilroy", size: 17)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        
                        ZStack (alignment: .leading){
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 327, height: 80)
                                .background(Color(red: 0.15, green: 0.16, blue: 0.22))
                                .cornerRadius(16)
                                .padding(.leading, -8)
                            HStack{
                                ZStack {
                                    Image("planet")
                                        .frame(width: 22, height: 20)
                                        .padding(.leading, 4)
                                }
                                .frame(width: 64, height: 64)
                                .background(Color(red: 0.1, green: 0.11, blue: 0.16))
                                .cornerRadius(10)
                                VStack{
                                    // Location
                                    Text(character.location.name)
                                        .font(
                                            Font.custom("Gilroy", size: 17)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(.white)
                                    
                                    Text("Planet")
                                        .font(
                                            Font.custom("Gilroy", size: 13)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.28, green: 0.77, blue: 0.04))
                                }
                            }
                        }
                        .frame(width: 327, height: 80)
                        
                        ForEach(character.episode, id: \.self) { episodeURL in
                            EpisodeView(episodeURL: episodeURL)
                                .padding(.vertical, 8)
                        }
                        
                    }
                    .navigationBarHidden(true)
                }
                .ignoresSafeArea(.all) // Ignore safe area for the entire ZStack
            }
        }
    }
}


//MARK: -- Episode View for particular episode
struct EpisodeView: View {
    let episodeURL: String
    
    @State private var episode: Episode?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 327, height: 86)
                .background(Color(red: 0.15, green: 0.16, blue: 0.22))
                .cornerRadius(16)
            
            VStack(alignment: .leading) {
                if let episode = episode {
                    
                    VStack{
                        HStack{
                            Text(episode.name)
                                .font(
                                    Font.custom("Gilroy", size: 17)
                                    .weight(.semibold)
                                )
                                .frame(alignment: .trailing)
                                .foregroundColor(.white)
                        }
                        Spacer(minLength: 1)
                        HStack{
                            Text(episode.episode)
                                .font(
                                    Font.custom("Gilroy", size: 13)
                                    .weight(.medium)
                                )
                                .frame(alignment: .leading)
                                .padding(.leading, 44)
                                .foregroundColor(Color(red: 0.28, green: 0.77, blue: 0.04))
                            
                            Spacer()
                            
                            Text(episode.air_date)
                              .font(
                                Font.custom("Gilroy", size: 12)
                                  .weight(.medium)
                              )
                              .frame(alignment: .trailing)
                              .padding(.trailing, 44)
                              .multilineTextAlignment(.trailing)
                              .foregroundColor(Color(red: 0.58, green: 0.6, blue: 0.61))
                        }
                    }
                    
                    
                    
                } else {
                    Text("Loading Episode...")
                }
            }
            .padding()
        }
        .onAppear { // Fetch episode data when the view appears
            fetchEpisodeData()
        }
    }
    
    private func fetchEpisodeData() {
        guard let url = URL(string: episodeURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let episode = try decoder.decode(Episode.self, from: data)
                    DispatchQueue.main.async {
                        self.episode = episode
                    }
                } catch {
                    print("Error decoding episode data: \(error)")
                }
            }
        }.resume()
    }
}
