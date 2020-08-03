import QtQuick 2.4
import QtQuick.Window 2.12
Item {
    width: 800
    height: 600
     visible:  true
    Column {
        anchors.centerIn: parent
        Text {
            id: text1
            font {
                family: "Comic Sans MS"
                pixelSize: 60
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: text2
            font {
                family: "Comic Sans MS"
                pixelSize: 20
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true

        onTriggered: {
            var date = new Date()
            text1.text = date.toLocaleTimeString(Qt.locale("en_US"), "hh:mm")
            text2.text = date.toLocaleDateString(Qt.locale("en_US"), "dd.MM.yyyy")
        }
    }
}
