//
//  VoteView.swift
//  JKHProject
//
//  Created by Alexey Khorikov on 22.08.2020.
//

import SwiftUI



struct VoteModel: Identifiable, Hashable, Codable {
    
    var id: UUID = UUID()
    var categoryImg: String
    var shortTitle: String
    var title: String = ""
    var voteArticles: [VoteArticleModel] = []
    var checked: Bool

}

struct VoteArticleModel: Identifiable, Hashable, Codable {
    
    var id: UUID = UUID()
    var title: String
    var area: String = ""
    var costByOne: String = ""
    var middleCost: String = ""
    var checked: Bool

}


struct VoteView: View {
    
    
    var VoteItems: [VoteModel] = [
        VoteModel(categoryImg: "house",
                  shortTitle: "Смета рассходов по перечню обязательных работ и услуг",
                  title: "Смета расходов по перечню обязательных работ и услуг по содержанию общего имущества собственников помещений многоквартирного дома по ул. Новокузнецкой 180",
                  voteArticles: [
            VoteArticleModel(title: "Содержание помещений  общего пользования", checked: false),
                    VoteArticleModel(title: "Уборка земельного участка, входящего в состав имущества МКД", area: "6510", costByOne: "1,67", middleCost: "1,68", checked: false),
                    VoteArticleModel(title: "Ремонтные сантехнические работы общего имущества", checked: false),
                    VoteArticleModel(title: "Техническое обслуживание электрооборудования", checked: false),
                    VoteArticleModel(title: "Затраты на управление", checked: false),
                    VoteArticleModel(title: "Текущие ремонтно-строительные работы", checked: false)
        ], checked: false ),
        VoteModel(categoryImg: "man", shortTitle: "Обустройство придомовой территории для инвалидов", checked: false),
        VoteModel(categoryImg: "children", shortTitle: "Детская площадка или лифт?", checked: true),
        VoteModel(categoryImg: "work", shortTitle: "Энергооэффективный капремонт", checked: false),
        VoteModel(categoryImg: "house", shortTitle: "Смета рассходов по перечню обязательных работ и услуг", checked: false)
        ]
    
    func sectionIndex(section : VoteModel) -> Int {
        VoteItems.firstIndex(where: {$0.id == section.id})!
    }
    
    var body: some View {
       NavigationView {
        VStack {
            HStack {
                Text("Голосование").foregroundColor(Color("tabColor")).bold().font(.largeTitle).padding(.all, 0)
                Spacer()
            }.padding(.horizontal)
            ScrollView() {
                
                ForEach(self.VoteItems, id: \.self) { i in
                    NavigationLink(destination: DetailVoteView(voteItem:  self.VoteItems[self.sectionIndex(section: i)])) {
                        VoteCardView(voteItem:  self.VoteItems[self.sectionIndex(section: i)])
                    }
                }
            }.padding(.bottom, 50)
            
            
        }.navigationBarHidden(true)
        }.navigationBarHidden(true)
        
    }
}

struct DetailVoteView: View {
    @State var voteItem: VoteModel
    
    func quoteIndex(quote : VoteArticleModel) -> Int {
            return voteItem.voteArticles.firstIndex(where: {$0.id == quote.id})!
    }
    
    var body: some View {
        NavigationView {
                  VStack{
                    if (!self.voteItem.checked) {
                        Text(self.voteItem.title).font(.title).foregroundColor(Color("tabColor")).bold().padding(.top, -30).padding(.horizontal)
                        HStack(alignment: .bottom) {
                            Text("Наименование статей расходов").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).frame(width: 190).lineSpacing(6.0)
                            Spacer()
                            Text("Согласен").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).frame(width: 150).lineSpacing(7.0)
                        }.padding(.horizontal).padding(.top)
                          ScrollView {
                            ForEach(self.voteItem.voteArticles, id: \.self) {i in
                                HStack {
                                    
                                    NavigationLink(destination: DatailsOfArticalView(voteItem: self.voteItem, article: i)) {
                                        Text(i.title).padding().font(.title3).foregroundColor(.black).lineSpacing(7.0).padding(.trailing)
                                    }
                                    Spacer()
    //                                Image(systemName: i.checked ? "checkmark.square" : "square").padding(.horizontal)
                                    ZStack {
                                        Rectangle()
                                            .fill(Color("tabColor"))
                                                                    .frame(width:30, height:30, alignment: .center).cornerRadius(5)
                                        if (i.checked) {
                                            Image(systemName: "checkmark").foregroundColor(.white)
                                        }
                                        
                                    }.padding().onTapGesture(perform: {
                                        self.voteItem.voteArticles[self.quoteIndex(quote: i)].checked.toggle()
                                    })
                                    
                                }.background(Color(.white)).padding(.horizontal, 20).padding(.vertical, 3)
                                .clipped()
                                .shadow(radius: 3, x: 0, y: 2)
                            }
                          }
                    } else {
                        EndedVote()
                    }
                    
                  }.navigationBarItems(leading: HStack {
                      NavigationLink(destination: VoteView()) {
                          Image("back")
                      }
                  })
              }.navigationBarHidden(true)
    }
    
}

struct DatailsOfArticalView: View {
    @State var voteItem: VoteModel
    @State var article: VoteArticleModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(self.article.title).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().foregroundColor(Color("tabColor")).padding()
            HStack {
                Text("План \nна месяц").font(.body).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.trailing, 10)
                Text("Затраты \nна 1 м2").font(.body).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal, 15)
                Text("Средняя цена по городу на 1 м2").font(.body).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal, 6)
            }.padding()
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 75) {
                Text(self.article.area).font(.body).padding(.leading, 10).padding(.vertical, 10)
                Text(self.article.costByOne).font(.body).padding(.vertical, 10)
                Text(self.article.middleCost).font(.body).padding(.trailing).padding(.vertical, 10)
                Spacer()
            }.background(Color(.white)).padding(.horizontal).clipped().shadow(radius: 4, x: 0, y: 2)
            Text("Вас заинтересует").font(.title2).bold().foregroundColor(Color("newsColor")).padding()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    VStack {
                        Image("grass").resizable().aspectRatio(contentMode: .fit)
                        Text("БлагоСервис РнД").font(.title3).bold().foregroundColor(Color("tabColor")).padding(.top, -10)
                        HStack {
                            Text("Цена за 1 м2").font(.callout).foregroundColor(.gray)
                            Spacer()
                            Text("1,58").font(.callout).foregroundColor(.black)
                        }.padding(.horizontal).padding(.top, 5)
                    }
                    VStack {
                        Image("kosa").resizable().aspectRatio(contentMode: .fit)
                        Text("Ремонтстрой РнД").font(.title3).bold().foregroundColor(Color("tabColor")).padding(.top, -10)
                        HStack {
                            Text("Цена за 1 м2").font(.callout).foregroundColor(.gray)
                            Spacer()
                            Text("1,67").font(.callout).foregroundColor(.black)
                        }.padding(.horizontal).padding(.top, 5)
                    }.padding(.top, 40)
                    VStack {
                        Image("blag").resizable().aspectRatio(contentMode: .fit)
                        Text("БлагоСервис РнД").font(.title3).bold().foregroundColor(Color("tabColor")).padding(.top, -10)
                        HStack {
                            Text("Цена за 1 м2").font(.callout).foregroundColor(.gray)
                            Spacer()
                            Text("1,58").font(.callout).foregroundColor(.black)
                        }.padding(.horizontal).padding(.top, 5)
                    }
                    VStack {
                        Image("lop").resizable().aspectRatio(contentMode: .fit)
                        Text("БлагоСервис РнД").font(.title3).bold().foregroundColor(Color("tabColor")).padding(.top, -10)
                        HStack {
                            Text("Цена за 1 м2").font(.callout).foregroundColor(.gray)
                            Spacer()
                            Text("1,58").font(.callout).foregroundColor(.black)
                        }.padding(.horizontal).padding(.top, 5)
                    }
//                    ForEach(1...4, id: \.self) { item in
//                                    Text("item")
//                                }
                            }
            }.padding(.bottom, 60)
        }.padding(.top, -60).navigationBarItems(leading: HStack {
            NavigationLink(destination: DetailVoteView(voteItem: self.voteItem)) {
                Image("back")
            }
        }).navigationBarBackButtonHidden(true)
        
    }
}


struct EndedVote: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Детская площадка или лифт?").font(.title2).bold().foregroundColor(Color("tabColor")).padding(.horizontal)
            Image("ChildrenPlace").resizable().aspectRatio(contentMode: .fit).padding(.horizontal, 5)
            VStack(alignment: .leading) {
                Text("Детская площадка").font(.title3).foregroundColor(.black)
                Image("stolb1").resizable().aspectRatio(contentMode: .fit)
            }.padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Лифт").font(.title3).foregroundColor(.black)
                Image("stolb2").resizable().aspectRatio(contentMode: .fit)
            }.padding(.horizontal)
            
            VStack(alignment: .center) {
                Spacer()
                HStack {
                    Spacer()
                    Text("Голосование окончено!").font(.title2).foregroundColor(Color("voteFont")).padding()
                    Spacer()
                }
                
                Spacer()
            }
            
            
        }.padding(.top, -50)
        
    }
}


struct VoteCardView: View {
    
    var voteItem: VoteModel
    
    var body: some View {
        
        HStack {
            Image(self.voteItem.categoryImg).resizable().aspectRatio(contentMode: .fit).padding(.vertical).padding(.leading)
            
                Text(self.voteItem.shortTitle).font(.body).foregroundColor(Color("voteFont"))
                    .padding(.trailing, 20)
            
           
            Image("circle").resizable().aspectRatio(contentMode: .fit).frame(width: 57, height: 57, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.trailing, 30)
        }.background(Color("newsColor")).padding(.horizontal)
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
