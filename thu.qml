import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window  {
    id: window
    width: 1024
    height: 800
    visible: true
    StackView {
           id: stack
           initialItem: "Caidat.qml"
           anchors.fill: parent
       }

       Component {
           id: mainView

           Row {
               spacing: 10

               Button {
                   text: "Push"
                   onClicked: stack.push(mainView)
               }
               Button {
                   text: "Pop"
                   enabled: stack.depth > 1
                   onClicked: stack.pop()

               }
               Text {
                   text: stack.depth
               }
           }
       }

}


