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
        for (i = 0;i<HieuChinh.q_parameterList.length;i++)
        {
            parameter_name.append({name: HieuChinh.q_parameterList[i]})
        }
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
                    width: 153
                    height: 53
                    digiOnly:( modelData == "Nơi sản xuất") ? false :true
                    Text {
                        text: modelData
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
    PrimaryButton{
        id: submit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
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

    }
}


