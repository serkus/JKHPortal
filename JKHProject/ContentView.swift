//
//  ContentView.swift
//  JKHProject
//
//  Created by Alexey Khorikov on 22.08.2020.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    @State var startScreen = true
    @State var index: Int = 0
    @State var offset: CGFloat = 0
    @State private var isGestureActive: Bool = false
    
    
    var body: some View {
        if (startScreen) {
            VStack {
                
                GeometryReader { geometry in
                    VStack {
                        
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -5) {
                        VStack {
                            Text("Управляй просто").font(.largeTitle).bold().foregroundColor(Color("tabColor"))
                            Image("pic1").resizable().aspectRatio(contentMode: .fit)
                        }.frame(width: geometry.size.width, height: 400)
                        VStack {
                            Text("Решай эффективно").font(.largeTitle).bold().foregroundColor(Color("tabColor"))
                            Image("pic2").resizable().aspectRatio(contentMode: .fit)
                        }.padding().frame(width: geometry.size.width, height: 400)
                        VStack {
                            Text("Контролируй и экономь").font(.largeTitle).bold().foregroundColor(Color("tabColor"))
                            Image("pic3").resizable().aspectRatio(contentMode: .fit)
                        }.padding().frame(width: geometry.size.width + 20, height: 400)
                
                    }
                }.content.offset(x: self.isGestureActive ? self.offset : -geometry.size.width * CGFloat(self.index))
                .frame(width: geometry.size.width, height: nil, alignment: .leading).gesture(DragGesture().onChanged ({ value in
                    self.isGestureActive = true
                    self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                }).onEnded({ value in
                    if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < 3 - 1 {
                        self.index += 1
                    }
                    if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                        self.index -= 1
                    }
                    withAnimation(.easeInOut(duration: 0.5)) { self.offset = -geometry.size.width * CGFloat(self.index) }
                    DispatchQueue.main.async { self.isGestureActive = false }
                }))
                    HStack {
                        Button(action: {
                            self.startScreen = false
                        }, label: {
                            Text("Пропустить").foregroundColor(Color("voteFont"))
                        })
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                            if (self.index >= 0 && self.index < 3 - 1 || self.index > 0) {
                                self.index = 0
                            }
                            }
                        }, label: {
                            Circle().fill(self.index == 0 ? Color("tabColor") : Color("voteFont")).frame(width: 10, height: 10)
                        })
                        Button(action: {
                            withAnimation {
                            if (self.index >= 0 && self.index < 3 - 1 || self.index > 0) {
                                self.index = 1
                            }
                            }
                        }, label: {
                            Circle().fill(self.index == 1 ? Color("tabColor") : Color("voteFont")).frame(width: 10, height: 10)
                        })
                        Button(action: {
                            withAnimation {
                            if (self.index >= 0 && self.index < 3 - 1) {
                                self.index = 2
                            }
                            }
                        }, label: {
                            Circle().fill(self.index == 2 ? Color("tabColor") : Color("voteFont")).frame(width: 10, height: 10)
                                
                        }).padding(.trailing)
                        Spacer()
                        Button(action: {
                            withAnimation {
                            if (self.index >= 0 && self.index < 3 - 1) {
                                self.index += 1
                            } else {
                                self.startScreen = false
                            }
                            }
                        }, label: {
                            Text("Далее").foregroundColor(.black)
                        })
                    }.padding()
                    }.padding(.top,150)
                
                }
            }
        } else {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        if (self.selectedTab == 0) {
                            MainView()
                        } else if (self.selectedTab == 1) {
                            VoteView()
                        }
                        
                    VStack {
                        Spacer()
                            HStack {
                                Button(action: {
                                    self.selectedTab = 0
                                }, label: {
                                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -15) {
                                        Image("home")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                                        Text("Главная").font(.subheadline).opacity(0.6)
                                    }.frame(width: geometry.size.width/6, height: 75)
                                    .foregroundColor(.white)
                                })
                               
                                
                                Button(action: {
                                    self.selectedTab = 1
                                }, label: {
                                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -15) {
                                Image("checkbox")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    .padding(EdgeInsets(top: 6, leading: 28, bottom: 20, trailing: 28))
                                    
                                    Text("Голосование").font(.footnote).opacity(0.6)
                                }.frame(width: geometry.size.width/5, height: 75)
                                .foregroundColor(.white)
                                }
                                )
                                
                                Button(action: {
                                    self.selectedTab = 2
                                }, label: {
                                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -15) {
                                    Image("chat")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                                    
                                    Text("Чат").font(.footnote).opacity(0.6)
                                }.frame(width: geometry.size.width/6, height: 75)
                                .foregroundColor(.white)
                                })
                                
                                Button(action: {
                                    self.selectedTab = 3
                                }, label: {
                                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -15) {
                                    Image("person")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                                    
                                    Text("Профиль").font(.footnote).opacity(0.6)
                                
                                }.frame(width: geometry.size.width/6, height: 75)
                                .foregroundColor(.white)
                                
                                }
                                )
                                
                                Button(action: {
                                    self.selectedTab = 4
                                }, label: {
                                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -15) {
                                Image("gear")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                                        
                                    Text("Настройки").font(.footnote).opacity(0.6)
                                }.frame(width: geometry.size.width/6, height: 75)
                                .foregroundColor(.white)
                                }
                                )
                                      
                            }.frame(width: geometry.size.width, height: geometry.size.height/10)
                            .background(Color("tabColor").shadow(radius: 3))
                        }
                           
                    }
    //                        MainView().environmentObject(RecycleCodesObserve())
    //                        MainView()
    //                            .tabItem({
    //                                Image(systemName: "house")
    //                                    .font(.system(size: 22))
    //                            }).tag(0)
    //                        RecycleMap()
    //                            .tabItem({
    //                                Image(systemName: "map")
    //                                    .font(.system(size: 22))
    //                            }).tag(1)
    //
    //
    //                        CardRow()
    //                            .environmentObject(RecycleCodesObserve())
    //                            .tabItem({
    //                                Image(systemName: "square.on.square")
    //                                    .font(.system(size: 22))
    //                            }).tag(2)
    //
    //                        TestRow()
    //                            .tabItem({
    //                                Image("we")
    //                                    .font(.system(size: 22))
    //                            }).tag(3)
    //
    //                        Settings()
    //                            .tabItem({
    //                                Image("hamburger")
    //                                    .font(.system(size: 22))
    //                            }).tag(4)
                        
                        
                    }.accentColor(.white)
                    .edgesIgnoringSafeArea(.all)
                            
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
        }
    }
}



