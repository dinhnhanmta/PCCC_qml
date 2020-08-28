import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
Item {
    anchors.fill: parent
    Component.onCompleted:
    {
        screenLabel.text = qsTr("HIỆU CHỈNH THAM SỐ HỆ THỐNG")
        var i = 0
        console.log(HieuChinh.q_parameterList)
        for (i = 0;i<HieuChinh.q_parameterList.length;i++)
        {parameter_name.append({name: HieuChinh.q_parameterList[i].padEnd(10," ")})}
    }

    Rectangle{
        anchors.fill: parent
        color: "lightblue"

    GridLayout{
            width: parent.width
            height:parent.height
            columns: 3
            anchors.centerIn: parent
        Repeater {
            id: repeat
            model: parameter_name
            Text {
                text: modelData
            Input{
                anchors.left: parent.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            }
        }
    }

    ListModel {
         id: parameter_name
    }
    }

}
