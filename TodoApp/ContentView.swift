//
//  ContentView.swift
//  TodoApp
//
//  Created by SHIGE on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @State var inputText = ""
    @State var toDoList = [(title: "タップで完了", completed: false)]
    var body: some View {
        ZStack {
            VStack {
                Text("やることリスト")
                    .padding()
                List(0..<toDoList.count, id: \.self) { index in
                    HStack {
                        Button {
                            toDoList[index].completed.toggle()
                            //ラベル名atで呼び出している
                            //removeToDo関数の引数indexに、Listのクロージャー内引数indexを代入している
                            removeToDo(at: index)
                        } label: {
                            Image(systemName: toDoList[index].completed == true ? "checkmark.circle.fill" : "circle" )
                        }
                        Text(toDoList[index].title)
                    }
                }
                .listStyle(.plain)
                HStack {
                    TextField("テキスト", text: $inputText, prompt: Text("やることを追加"))
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            if inputText != "" {
                                toDoList.append((title: inputText, completed: false))
                                inputText = ""
                            } else {
                                return
                            }
                        }
                    //------------↓todoを追加する際に「追加」ボタンを使用していたときのメモ------------------------------------------------
                    //.disabledメソッドの引数にはBool型(が返される式)を入れる。ラベル名は省略されている。
                    //返り値はsome View型なので、無効化されたViewが返される。
                    //.isEmptyはString型に定義されているプロパティ
                    //.trimmingCharactersはString型に定義されているメソッド。in:の中で指定した文字列を削除する。.whitespacesの前にはCharacterSet構造体が省略されている。つまり.whitespacesはタイププロパティ。
                    //.isEmptyはBool型の値を返すプロパティ。空であればtrue、そうでなければfalseを返す。Swiftの標準ライブラリに定義されたプロパティ。
                    //------------------------------------------------------------------------------------------------------------
                }
            }
        }
    }
    
    //(at index: Int)のatはただのラベル名(remove(at:)のatではない)
    func removeToDo(at index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //こっちのatは(remove(at:)のat
            //indexはremoveToDo(at index: Int)のindex
            toDoList.remove(at: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
