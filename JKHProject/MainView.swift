//
//  MainView.swift
//  JKHProject
//
//  Created by Alexey Khorikov on 22.08.2020.
//

import SwiftUI


struct NewsModel: Identifiable, Hashable, Codable {
    
    var id: UUID = UUID()
    var text: String
    var imageName: String
    var date: String

}



struct MainView: View {
    
    
    var NewsItems: [NewsModel] = [
        NewsModel(text: "Продставитель совета дома может по решению ОСС подать договор с УО", imageName: "newImg1", date: "22.08.2020" ),
        NewsModel(text: "После прошедшего опроса принято решение установить во дворе детскую площадку", imageName: "newsImg2", date: "15.08.2020"),
        NewsModel(text: "Эксперты ОНФ обсудили вопросы проведения капремонта ветхого жилфонда", imageName: "newsImg3", date: "15.07.2020"),
        NewsModel(text: "Просим принять участие в вопросе по замене лифтов", imageName: "newsImg4", date: "12.07.2020")
        ]
    
    func sectionIndex(section : NewsModel) -> Int {
        NewsItems.firstIndex(where: {$0.id == section.id})!
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Новости").foregroundColor(Color("newsColor")).font(.largeTitle).bold().padding(.all, 0)
                    Spacer()
                }.padding(.horizontal)
                ScrollView() {
                    ForEach(self.NewsItems, id: \.self) { i in
                        NavigationLink(destination: NewsItemDetailView()) {
                            NewsItemView(newsItem: self.NewsItems[self.sectionIndex(section: i)])
                        }.frame(height: 210)
                    }
                }.padding(.bottom, 50)
                
                
            }.navigationBarHidden(true)
            }.navigationBarHidden(true)
            
//        CustomNavigationView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}


