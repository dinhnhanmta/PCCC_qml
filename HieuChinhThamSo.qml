import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12


Item {
    anchors.fill: parent
    Component.onCompleted:
    {
        screenLabel.text = qsTr("HIỆU CHỈNH THAM SỐ HỆ THỐNG")
        var i = 0
        if (repeat.count===0)
        for (i = 0; i < HieuChinh.q_parameterList.length;i++)
        {
            parameter_name.append({name: HieuChinh.q_parameterList[i]})
        }
    }

    Constants {
      id: constants;
    }

    Rectangle{
        anchors.fill: parent
        color: "#ddf6fe"

        GridLayout{
            width: parent.width
            height:parent.height
            columns: 4
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.top: parent.top
            Repeater {
                id: repeat
                model: parameter_name

                Input{
                    digiOnly:( modelData == "Nơi sản xuất") ? false :true

                    Text {
                        text: modelData
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
            }
        ]

    }
}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
