import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("LỊCH SỬ THỬ NGHIỆM")
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
    }

}
