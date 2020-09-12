import QtQuick 2.0
import QtCharts 2.3
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
Item {
    id: window
    width: 1024
    height: 600
    visible: true

    Component.onCompleted: {
        Modbus.startConnection();
        Cambien.openSerialPort();
        screenLabel.text = qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
    }

    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        Text {

            id: screenLabel
            y: 18
            height: 40
            color: "#0335b8"
            text: qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
            font.capitalization: Font.AllUppercase
            font.weight: Font.ExtraBold
            style: Text.Outline
            anchors.horizontalCenterOffset: 13
            font.bold: true
            font.family: "Tahoma"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 27
        }

        StackView {
            id: stack2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: screenLabel.bottom
            anchors.bottom: footer.top
            anchors.topMargin: 20
            replaceEnter: Transition {
                  PropertyAnimation{
                      property: "opacity"
                      from: 0
                      to: 1
                      duration: 300
                  }
              }

              replaceExit: Transition {
                  PropertyAnimation{
                      property: "opacity"
                      from: 1
                      to: 0
                      duration: 250
                  }
              }

            Row {
                width: parent.width - 20
                height: parent.height
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.top: parent.top
                    width: parent.width/2
                    anchors.topMargin: 30
                    spacing: parent.height/3 - 120

                    PrimaryButton{
                        id: thuNghiem
                        height: 100
                        radius: 1
                        text: "              TIẾN HÀNH THỬ NGHIỆM"
                        border.color: "#4dade9"
                        activeFocusOnTab: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/play2.png"
                            anchors.left:  parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("KiemDinhTD.qml")
//                            onClicked: stack2.push("DangNhapTB.qml")
                        }
                    }

                    PrimaryButton {
                        id: capNhat
                        height: 100
                        radius: 1
                        text: "                 CẬP NHẬT THÔNG SỐ\n                        KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/update2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked:
                                {
                                HieuChinh.readJson()
                                stack2.push("HieuChinhThamSo.qml")
                                }
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem5
                        height: 100
                        radius: 1
                        text: "         CÀI ĐẶT HỆ THỐNG"
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/setting2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("CaiDatThongSo.qml")
                        }
                    }
                }

                Column {
                    anchors.top: parent.top
                    width: parent.width/2
                    anchors.topMargin: 30
                    spacing: parent.height/3 - 120

                    PrimaryButton {
                        id: thuNghiemBangTay
                        height: 100
                        radius: 1
                        text: "                THỬ NGHIỆM BẰNG TAY"
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/hand2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            height: 64
                            anchors.fill: parent
                            onClicked: stack2.push("ThuNghiemBangTay.qml")
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem2
                        y: 175
                        height: 100
                        radius: 1
                        text: "LỊCH SỬ KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/history2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("LichSuKiemDinh.qml")
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem4
                        height: 100
                        radius: 1
                        text: "         HIỆU CHỈNH THÔNG SỐ"
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: stack2.empty
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/adjust2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            height: 100
                            anchors.fill: parent
                            onClicked: stack2.push("HieuChinhThamSo2.qml")
                        }
                    }
                }
            }
        }

        Image {
            id: userAvatar
            source: "qrc:/Icon/account.png"
            scale: 0.8
            anchors.right: parent.right
            anchors.top: parent.top
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stack2.clear()
                    stack2.push("Menu.qml")
                }
            }
        }

        Text {
            anchors.right: userAvatar.left
            height: userAvatar.height
            text: qsTr("Xin chào\n") + QLogin.displayedNamed()
            font.pointSize: 10
            font.weight: Font.Bold
            font.family: "Tahoma"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }


        Row {
            id: footer
            y: 551
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 50
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0




            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom:  parent.bottom
                height: homeBtn.height
                color: "palegoldenrod"
                width: perphiralStatusTxt.width + perphiralStatus.width + 30
                Text {
                    id: perphiralStatusTxt
                    anchors.top: perphiralStatus.top
                    anchors.right: perphiralStatus.left
                    height: homeBtn.height
                    text: qsTr("Kết nối\nngoại vi")
                    horizontalAlignment: Text.AlignHCenter
                    style: Text.Normal
                    font.weight: Font.ExtraBold
                    font.capitalization: Font.AllUppercase
                    font.family: "Tahoma"
                    anchors.rightMargin: 15
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 15
                }
                DangerButton {
                    id: perphiralStatus
                    width: 100
                    height: homeBtn.height
                    text: ""
                    radius: 1
                    color: "palegoldenrod"
                    anchors.right: parent.right
                    anchors.bottom:  parent.bottom
                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: Cambien.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                        scale: 0.7
                    }
                }
            }

            Rectangle{
                anchors.right: parent.right
                anchors.bottom:  parent.bottom
                height: homeBtn.height
                color: "palegoldenrod"
                width: sensorStatusTxt.width + sensorStatus.width + 30
                Text {
                    id: sensorStatusTxt
                    anchors.top: sensorStatus.top
                    anchors.right: sensorStatus.left
                    height: homeBtn.height
                    text: qsTr("Kết nối\ncảm biến")
                    horizontalAlignment: Text.AlignHCenter
                    font.weight: Font.ExtraBold
                    font.capitalization: Font.AllUppercase
                    anchors.rightMargin: 15
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 15
                }
                DangerButton {
                    id: sensorStatus
                    text: ""
                    color: "palegoldenrod"
                    radius: 1
                    width: 100
                    height: 55
                    anchors.right: parent.right
                    anchors.bottom:  parent.bottom
                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                        scale: 0.7
                    }
                }
            }



            DangerButton {
                id: homeBtn
                text: "Home"
                color: "palegoldenrod"
                radius: 3
                width: 200
                height: 55
                anchors.left: parent.left
                anchors.bottom:  parent.bottom
                Image {
                    source: "qrc:/Icon/home2.png"
                    anchors.left: parent.left
                    scale: 0.5
                }
                MouseArea {
                    anchors.topMargin: 0
                    anchors.fill: parent
                    onClicked: {
                        screenLabel.text = qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
                        if (!stack2.empty) stack2.clear()
                        screenLabel.text = qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
                    }
                }
            }
        }

    }
}















/*##^## Designer {
    D{i:28;anchors_height:50;anchors_width:100}D{i:32;anchors_height:50;anchors_width:100}
}
 ##^##*/
