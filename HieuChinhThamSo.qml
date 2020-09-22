import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.1

Item {
    id: hieuchinhthamso
    anchors.fill: parent
    Component.onCompleted:
    {
        screenLabel.text = qsTr("HIỆU CHỈNH THAM SỐ HỆ THỐNG")
        var i = 0
        if (repeat.count===0)
        for (i = 0; i < HieuChinh.q_parameterList.length;i++)
        {
            parameter_name.append({name: HieuChinh.q_parameterList[i],paravalue: HieuChinh.q_parameterValueList[i]})

        }

    }

    MessageDialog {
        id: messageDialog
        title: "Lỗi"
        icon: StandardIcon.Critical
        text: "Lưu dữ liệu không thành công"
    }

    Connections {
        target: HieuChinh
        onSubmitSuccess: {
            if (!stack2.empty) stack2.clear()
        }
        onSubmitFailed: {
            messageDialog.visible = true;
        }
        onUnauthorized: {
            stack2.pop()
            stack.pop()
            stack.push("Login.qml")
        }
    }

    Constants {
      id: constants;
    }

    Rectangle{
        anchors.fill: parent
        color: "#ddf6fe"

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Code:")
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 10
                text: LoginTB.deviceModelCode()
                font.bold: true
            }

            Text {
                text: LoginTB.deviceModelName()
                anchors.right: parent.left
                anchors.rightMargin: 10
                font.bold: true
                Text {
                    id: thietbiText
                    anchors.right: parent.left
                    anchors.rightMargin: 10
                    text: qsTr("Thiết bị:")

                    }
                }
        }


        GridLayout{
            width: parent.width
            height:parent.height
            columns: 4

            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 30
            Repeater {
                id: repeat
                model: parameter_name
                delegate:
                Rectangle{
                    height: 50
                    width: 200
                    Input{
                        anchors.fill: parent
                        digiOnly:( name === "Nơi sản xuất") ? false :true
                        initText: paravalue
                    }
                    Text {
                        text: name
                        font.pointSize: 13
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 10
                        anchors.horizontalCenter:  parent.horizontalCenter
                    }
                }
            }
        }

        ListModel {
             id: parameter_name
        }
    }
    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 200
        children: [
            PrimaryButton{
                id: failedBtn
                width: 153
                height: 53
                color: constants.carrot
                text: "CHƯA ĐẠT"
            },
            PrimaryButton{
                id: submit
                width: 153
                height: 53
                text: "LƯU"
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        var obj = {};
                        for (var i=0;i<repeat.count;i++)
                        {
                            obj[repeat.model.get(i).name] = repeat.itemAt(i).text
                        }
                        HieuChinh.submitData(JSON.stringify(obj))
                    }
                }
            },
            PrimaryButton{
                id: passBtn
                width: 153
                height: 53
                color: constants.carrot
                text: "ĐẠT"
            }
        ]

    }
}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
