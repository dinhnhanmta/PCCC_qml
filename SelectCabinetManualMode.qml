import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.1

Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("LỰA CHỌN TỦ KIỂM ĐỊNH")

    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: "#ddf6fe"

        DefaultButton {
            id: btnTestApSuat
            x: 500
            width: 312
            height: 128
            color: "#1abc9c"
            radius: 10
            text: "THỬ NGHIỆM KHẢ NĂNG RÒ RỈ \n VÀ ĐỘ BỀN THỦY TĨNH"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 238
            highlightColor: "#a1a6a9"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: {
//                        stack2.push("KiemDinhBangTaySpinkler.qml")
                    stack2.push("ThuNghiemBangTay.qml")
                }
            }
        }

        DefaultButton {
            id: btnTestLuuLuong
            x: 0
            width: 312
            height: 128
            color: "#1abc9c"
            radius: 10
            text: "THỬ NGHIỆM \n LƯU LƯỢNG LƯỚC"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -233
            highlightColor: "#a1a6a9"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                onClicked: {
                    stack2.push("KiemDinhBangTaySpinkler.qml")
//                        stack2.push("ThuNghiemBangTay.qml")
                }
            }
        }



    }
}























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
