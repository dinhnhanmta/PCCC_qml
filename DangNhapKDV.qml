import QtQuick 2.12

import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0


Item {
    visible: true
    width: 1024
    height: 800
    id: loginPage

    Rectangle{
    anchors.fill: parent
    color: "#394454"

        Login { x: 356;y: 160
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

        }

        Text {
            id: element
            x: 332
            y: 70
            text: "DANG NHAP KIEM DINH VIEN"
            font.pixelSize: 26
            color: "white"
        }
    }

}
