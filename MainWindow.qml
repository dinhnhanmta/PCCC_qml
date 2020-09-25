import QtQuick 2.0
import QtCharts 2.3
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Dialogs 1.1

Item {
    id: window
    width: 1024
    height: 600
    visible: true

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Critical
        title: "Cấu hình loại thiết bị"
        text: "Vui lòng kiểm tra cấu hình loại thiết bị"
        onAccepted: {
            messageDialog.visible = false
        }
    }

    Component.onCompleted: {
        Modbus.startConnection();
        Cambien.openSerialPort();
        HieuChinh.getDeviceData();
        HieuChinh.getIParameterFromLocal();
        if (LoginTB.deviceModelName() === ""){
             stack2.push("DangNhapTB.qml")
        } else {
            screenLabel.text = qsTr("THIẾT BỊ KIỂM ĐỊNH " + LoginTB.deviceModelName());
        }
    }

    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: "#ddf6fe"

        Text {
            id: screenLabel
            x: 244
            anchors.top: parent.top
            anchors.topMargin: 16
            color: "#fd1d1d"
            text: qsTr("THIẾT BỊ KIỂM ĐỊNH " + LoginTB.deviceModelName())
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            font.capitalization: Font.AllUppercase
            font.family: "Tahoma"
            font.pixelSize: 27
            font.bold: true
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
                        radius: 4
                        text: "              KIỂM ĐỊNH TỰ ĐỘNG"
                        textColor: "black"
                        pointSize: 13
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
                            onClicked: {
                                if (LoginTB.logged()){
                                    stack2.push("KiemDinhTD.qml")
                                } else {
                                    stack2.push("DangNhapTB.qml")
                                }
                            }
                        }
                    }

                    PrimaryButton {
                        id: capNhat
                        height: 100
                        radius: 4
                        text: "                 CẬP NHẬT THÔNG SỐ\n                        KIỂM ĐỊNH"
                        pointSize: 13
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
                                    if (LoginTB.logged()){
                                        HieuChinh.readJson()
                                        HieuChinh.getIParameterFromLocal();
                                        stack2.push("HieuChinhThamSo.qml")
                                    } else {
                                        stack2.push("DangNhapTB.qml")
                                    }
                                }
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem5
                        height: 100
                        radius: 4
                        text: "         CÀI ĐẶT HỆ THỐNG"
                        border.color: "#1b26d2"
                        pointSize: 13
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
                        radius: 4
                        text: "                KIỂM ĐỊNH BẰNG TAY"
                        pointSize: 13
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
                            onClicked: {
                                if (LoginTB.logged()){
                                    stack2.push("ThuNghiemBangTay.qml")
                                } else {
                                    stack2.push("DangNhapTB.qml")
                                }
                            }
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem2
                        y: 175
                        height: 100
                        radius: 4
                        text: "      LỊCH SỬ KIỂM ĐỊNH"
                        pointSize: 13
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
                        radius: 4
                        text: "              HIỆU CHỈNH THÔNG SỐ"
                        pointSize: 13
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
                            anchors.fill: parent
                            onClicked: stack2.push("CalibParam.qml")
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
                radius: 5
                width: perphiralStatusTxt.width + perphiralStatus.width + 30
                Text {
                    id: perphiralStatusTxt
                    anchors.top: perphiralStatus.top
                    anchors.right: perphiralStatus.left
                    height: homeBtn.height
                    text: qsTr("Kết nối\nngoại vi")
                    font.bold: false
                    horizontalAlignment: Text.AlignHCenter
                    style: Text.Normal
                    font.weight: Font.ExtraBold
                    font.capitalization: Font.MixedCase
                    font.family: "Tahoma"
                    anchors.rightMargin: 15
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
                DangerButton {
                    id: perphiralStatus
                    width: 100
                    height: homeBtn.height
                    text: ""
                    radius: 7
                    color: "palegoldenrod"
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

            Rectangle{
                anchors.right: parent.right
                anchors.bottom:  parent.bottom
                height: homeBtn.height
                color: "palegoldenrod"
                radius: 5
                width: sensorStatusTxt.width + sensorStatus.width + 30
                Text {
                    id: sensorStatusTxt
                    anchors.top: sensorStatus.top
                    anchors.right: sensorStatus.left
                    height: homeBtn.height
                    text: qsTr("Kết nối\ncảm biến")
                    font.family: "Tahoma"
                    font.bold: false
                    horizontalAlignment: Text.AlignHCenter
                    font.weight: Font.ExtraBold
                    font.capitalization: Font.MixedCase
                    anchors.rightMargin: 15
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
                DangerButton {
                    id: sensorStatus
                    text: ""
                    color: "palegoldenrod"
                    radius: 3
                    width: 100
                    height: 50
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



            DangerButton {
                id: homeBtn
                text: "Home"
                color: "palegoldenrod"
                radius: 3
                width: 200
                height: 50
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
                        if (LoginTB.deviceModelName() !== ""){
                            screenLabel.text = "THIẾT BỊ KIỂM ĐỊNH " + LoginTB.deviceModelName()
                            if (!stack2.empty) stack2.clear()
                            screenLabel.text = qsTr("THIẾT BỊ KIỂM ĐỊNH " + LoginTB.deviceModelName())
                        } else {
                            messageDialog.visible = true
                        }
                    }
                }
            }
        }

    }
}




















/*##^## Designer {
    D{i:27;anchors_height:50;anchors_width:100}D{i:28;anchors_height:50;anchors_width:100}
D{i:31;anchors_height:50;anchors_width:100}D{i:32;anchors_height:50;anchors_width:100}
}
 ##^##*/
