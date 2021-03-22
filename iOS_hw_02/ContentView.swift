//
//  ContentView.swift
//  iOS_hw_02
//
//  Created by CK on 2021/3/16.
//

import SwiftUI


//建立牌
//???????????
var users : [[Int]] = [[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0]]
//%13餘數為rank 整除0 黑桃 1梅花 2 紅心 3菱形 /52 = back

var card:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12
                  ,13,14,15,16,17,18,19,20,21,22,23,24,25
                  ,26,27,28,29,30,31,32,33,34,35,36,37,38
                  ,39,40,41,42,43,44,45,46,47,48,49,50,51]


//發牌
func licensing(){
    
    var index = 0
    for i in 0...3{
        for j in 0...12{
            users[i][j] = card[index]
            index += 1
        }
    }
}
//排序
func sortCard(){
    for i in 0...3{
        var j = 0
        while j < 12 {
            
            if users[i][j] < users[i][j+1]{
                j+=1
            }
            else{
                var box = users[i][j+1]
                users[i][j+1] = users[i][j]
                users[i][j] = box
                j = 0
            }
        }
    }
}
//判斷花色

func whatCube(number: Int) -> Int{
    
    var cubeIndex = 5// 0桃1枚2愛3零
    switch number / 13 {
    case 0:
        cubeIndex = 0
    case 1:
        cubeIndex = 1
    case 2:
        cubeIndex = 2
    case 3:
        cubeIndex = 3
    default :
        print("end")
    }
    return cubeIndex
}
//誰先
func whoHavePlum7() -> Int{
    
    var havePlum7Index = 5
    
    var havePlum7 = users[0].contains { (value) -> Bool in
        value == 19
    }
    if havePlum7 == true{
        havePlum7Index = 0
    }
    havePlum7 = users[1].contains { (value) -> Bool in
        value == 19
    }
    if havePlum7 == true{
        havePlum7Index = 1
    }
    havePlum7 = users[2].contains { (value) -> Bool in
        value == 19
    }
    if havePlum7 == true{
        havePlum7Index = 2
    }
    havePlum7 = users[3].contains { (value) -> Bool in
        value == 19
    }
    if havePlum7 == true{
        havePlum7Index = 3
    }
    
    return havePlum7Index
}

struct ContentView: View {
    
    @State var j = 0
    @State var myCardNumber = users[0]
    @State var indexSpades_min = 6//桃7
    @State var indexSpades_Max = 6//桃7
    @State var indexPlum_min = 19//梅7
    @State var indexPlum_Max = 19//梅7
    @State var indexLove_min = 32//愛7
    @State var indexLove_Max = 32//愛7
    @State var indexCube_min = 45//菱7
    @State var indexCube_Max = 45//菱7
    @State var tableCard = [Int]()
    //7是否出過
    @State var Spades_7 = false
    @State var Plum_7 = false
    @State var Love_7 = false
    @State var Cube_7 = false
    //誰先
    @State var isMyturn_0 = false
    @State var isMyturn_1 = false
    @State var isMyturn_2 = false
    @State var isMyturn_3 = false
    @State var Money = 1000
    @State var nowTurn = 0
    /*
    func buildTableCard(num :Int){
        ForEach(0..<tableCard.count, id: \.self)//tableCard
        {
            index in
            if whatCube(number: tableCard[index]) == num {
                Image(String(tableCard[index]))
                .resizable()
                .background(Color.white)
                .frame(width: 60, height:60)
                .scaledToFit()
                .border(Color.black, width: 1)
                .offset(x: index > 0 ? -40 : 0, y: 0)
                .padding(.trailing, index > 0 ? -40 : 0)
            }
        }
    }
    */
    var body: some View {
    
        ZStack{
            Image("hw2背景")
                .opacity(0.6)
            VStack{
                VStack{
                    Image("錢")
                        .resizable()
                        .padding(.leading,5.0)
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                        .offset(x: 350, y: -90)
                    Text("money="+String(Money))
                        .offset(x: 350, y: -100)
                    Text("輪到"+String(nowTurn)+"號玩家")
                        .offset(x: 350, y: -100)
                    Button(action: {
                        switch  whoHavePlum7(){
                        case 0:
                            isMyturn_0 = true
                            nowTurn = 0
                        case 1:
                            isMyturn_1 = true
                            nowTurn = 1
                        case 2:
                            isMyturn_2 = true
                            nowTurn = 2
                        case 3:
                            isMyturn_3 = true
                            nowTurn = 3
                        default:
                            print("endwhoHavePlum7")
                            
                        }
                    }, label: {
                        Text("開始遊戲")
                    }).offset(x: 350, y: -100)
                    
                }
                
                
                HStack{// 桃
                    ForEach(0..<tableCard.count, id: \.self)//tableCard
                    {
                        index in
                        if whatCube(number: tableCard[index]) == 0 {
                            Image(String(tableCard[index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 60, height:60)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -40 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        }
                    }
                }
                HStack{//梅
                    ForEach(0..<tableCard.count, id: \.self)//tableCard
                    {
                        index in
                        if whatCube(number: tableCard[index]) == 1 {
                            Image(String(tableCard[index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 60, height:60)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -40 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        }
                    }
                }
                //愛
                HStack{
                    ForEach(0..<tableCard.count, id: \.self)//tableCard
                    {
                        index in
                        if whatCube(number: tableCard[index]) == 2 {
                            Image(String(tableCard[index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 60, height:60)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -40 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        }
                    }
                }
                //菱
                HStack{
                    ForEach(0..<tableCard.count, id: \.self)//tableCard
                    {
                        index in
                        if whatCube(number: tableCard[index]) == 3 {
                            Image(String(tableCard[index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 60, height:60)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -40 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        }
                    }
                }

                
//user0 (me
                HStack{
                    
                    ForEach(0..<users[0].count, id: \.self)//myCard
                    {
                        index in
                        Button(action:
                        {
                            print(users[0][index])
                            print(tableCard)
                            if isMyturn_0 == true{
                                
                                nowTurn = 0
                                
                                switch whatCube(number: users[0][index]) {//0桃1梅2愛3菱
                                case 0:
                                    if Spades_7 == false{
                                        
                                        if users[0][index]  == 6{ //7 = 7
                                            tableCard.append(users[0][index])
                                            Spades_7 = true
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                    if Spades_7 == true{
                                        
                                        if users[0][index] == indexSpades_min-1{
                                            indexSpades_min = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                        if users[0][index] == indexSpades_Max+1 {
                                            indexSpades_Max = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                    
                                case 1:
                                    if Plum_7 == false{
                                        
                                        if users[0][index]  == 19{ //7 = 7
                                            tableCard.append(users[0][index])
                                            Plum_7 = true
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                    if Plum_7 == true{
                                        
                                        if users[0][index] == indexPlum_min-1{
                                            indexPlum_min = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                        if users[0][index] == indexPlum_Max+1 {
                                            indexPlum_Max = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                case 2:
                                    if Love_7 == false{
                                            
                                        if users[0][index]  == 32{ //7 = 7
                                            tableCard.append(users[0][index])
                                            Love_7 = true
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                    if Love_7 == true{
                                        
                                        if users[0][index] == indexLove_min-1{
                                            indexLove_min = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                        if users[0][index] == indexLove_Max+1 {
                                            indexLove_Max = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                case 3:
                                    if Cube_7 == false{
                                            
                                        if users[0][index]  == 45{ //7 = 7
                                            tableCard.append(users[0][index])
                                            Cube_7 = true
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                    if Cube_7 == true{
                                        
                                        if users[0][index] == indexCube_min-1{
                                            indexCube_min = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                        if users[0][index] == indexCube_Max+1 {
                                            indexCube_Max = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                default :
                                    print("end")
                                }
                            }
                            if isMyturn_1 == true{
                                
                                nowTurn = 1
                                
                                switch whatCube(number: users[1][index]) {//0桃1梅2愛3菱
                                case 0:
                                    if Spades_7 == false{
                                        
                                        if users[1][index]  == 6{ //7 = 7
                                            tableCard.append(users[1][index])
                                            Spades_7 = true
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                    if Spades_7 == true{
                                        
                                        if users[1][index] == indexSpades_min-1{
                                            indexSpades_min = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                        if users[1][index] == indexSpades_Max+1 {
                                            indexSpades_Max = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                    
                                case 1:
                                    if Plum_7 == false{
                                        
                                        if users[1][index]  == 19{ //7 = 7
                                            tableCard.append(users[1][index])
                                            Plum_7 = true
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                    if Plum_7 == true{
                                        
                                        if users[1][index] == indexPlum_min-1{
                                            indexPlum_min = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                        if users[0][index] == indexPlum_Max+1 {
                                            indexPlum_Max = users[0][index]
                                            tableCard.append(users[0][index])
                                            users[0][index] = 53
                                            isMyturn_0 = false
                                            isMyturn_1 = true
                                        }
                                    }
                                case 2:
                                    if Love_7 == false{
                                            
                                        if users[1][index]  == 32{ //7 = 7
                                            tableCard.append(users[1][index])
                                            Love_7 = true
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                    if Love_7 == true{
                                        
                                        if users[1][index] == indexLove_min-1{
                                            indexLove_min = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                        if users[1][index] == indexLove_Max+1 {
                                            indexLove_Max = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                case 3:
                                    if Cube_7 == false{
                                            
                                        if users[1][index]  == 45{ //7 = 7
                                            tableCard.append(users[1][index])
                                            Cube_7 = true
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                    if Cube_7 == true{
                                        
                                        if users[1][index] == indexCube_min-1{
                                            indexCube_min = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                        if users[1][index] == indexCube_Max+1 {
                                            indexCube_Max = users[1][index]
                                            tableCard.append(users[1][index])
                                            users[1][index] = 53
                                            isMyturn_1 = false
                                            isMyturn_2 = true
                                        }
                                    }
                                default :
                                    print("end")
                                }
                            }
                            
                        }, label:
                        {
                            Image(String(users[0][index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 70, height:70)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -20 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        })
                        
                    }
                }
                //user1
                Button(action:
                {
                    ForEach(0..<users[1].count, id: \.self)
                    {
                    index in
                    switch whatCube(number: users[1][index]) {//0桃1梅2愛3菱
                    case 0:
                        if Spades_7 == false{
                            
                            if users[1][index]  == 6{ //7 = 7
                                tableCard.append(users[1][index])
                                Spades_7 = true
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                        if Spades_7 == true{
                            
                            if users[1][index] == indexSpades_min-1{
                                indexSpades_min = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                            if users[1][index] == indexSpades_Max+1 {
                                indexSpades_Max = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                        
                    case 1:
                        if Plum_7 == false{
                            
                            if users[1][index]  == 19{ //7 = 7
                                tableCard.append(users[1][index])
                                Plum_7 = true
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                        if Plum_7 == true{
                            
                            if users[1][index] == indexPlum_min-1{
                                indexPlum_min = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                            if users[1][index] == indexPlum_Max+1 {
                                indexPlum_Max = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                    case 2:
                        if Love_7 == false{
                                
                            if users[1][index]  == 32{ //7 = 7
                                tableCard.append(users[1][index])
                                Love_7 = true
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                        if Love_7 == true{
                            
                            if users[1][index] == indexLove_min-1{
                                indexLove_min = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_0 = false
                                isMyturn_1 = true
                            }
                            if users[1][index] == indexLove_Max+1 {
                                indexLove_Max = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                    case 3:
                        if Cube_7 == false{
                                
                            if users[1][index]  == 45{ //7 = 7
                                tableCard.append(users[1][index])
                                Cube_7 = true
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                        if Cube_7 == true{
                            
                            if users[1][index] == indexCube_min-1{
                                indexCube_min = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                            if users[1][index] == indexCube_Max+1 {
                                indexCube_Max = users[1][index]
                                tableCard.append(users[1][index])
                                users[1][index] = 53
                                isMyturn_1 = false
                                isMyturn_2 = true
                            }
                        }
                    default :
                        print("end")
                    }
                    }
                },label:{
                    Image("player1")
                        .resizable()
                        .padding(.leading,5.0)
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                        .offset(x: 350, y: -90)
                }
            )
                       
                            
                    
            }//vstack
            
            
        }
        }
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/844.0/*@END_MENU_TOKEN@*/, height: 390.0))
            .previewDevice("iPhone 11 ")
    }
}
