//
//  NewsItem.swift
//  JKHProject
//
//  Created by Alexey Khorikov on 22.08.2020.
//

import SwiftUI

struct NewsItemView: View {
//    @Binding var imgWidth: CGFloat;
//    @Binding var imgHeight: CGFloat;
    var newsItem: NewsModel
    
    @State var can = false
    
    func chackImgWidth(imgName: String) -> Bool {
        let img = UIImage(named: imgName)
        return (img?.size.width)! >= 300
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: -20) {
            if self.chackImgWidth(imgName: self.newsItem.imageName) {
            
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(self.newsItem.text).bold().font(.body).foregroundColor(.black).padding(.horizontal)
                    Image(self.newsItem.imageName).resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity, maxHeight: 190).padding(.top, -15).padding(.horizontal, 5)
                HStack {
                    Text(self.newsItem.date).foregroundColor(.gray)
                        .font(.body)
                        
                    Spacer()
                }.padding(.horizontal).padding(.top, -15)
                Rectangle().fill(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 3).padding(.horizontal).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }.padding(0)
            } else {
                VStack {
                    HStack(alignment: .top, spacing: -10) {
                        Image(self.newsItem.imageName).resizable().aspectRatio(contentMode: .fit).padding(.leading, -10)
                        VStack(alignment: .leading) {
                            Text(self.newsItem.text).bold().font(.callout).foregroundColor(.black).padding(.leading, 5)
                            HStack {
                                Text(self.newsItem.date).foregroundColor(.gray)
                                    .font(.body)
                                Spacer()
                            }.padding(.leading, 5).padding(.top, 10)
                        }.padding(.top, 10)
                    }.padding(.horizontal)
                    Rectangle().fill(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 3).padding(.horizontal).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct NewsItemDetailView: View {

    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    Text("hello")
                }
            }.navigationBarItems(leading: HStack {
                NavigationLink(destination: MainView()) {
                    Image("back")
                }
            })
        }.navigationBarHidden(true)
    }

}

//struct NewsItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        NewsItem()
//            .previewDevice("iPhone 11")
//    }
//}
