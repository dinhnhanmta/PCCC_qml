import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
Item {
    id: window
    width: 1024
    height: 800
    visible: true

    Canvas{
                id: drawingCanvas
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 1
                anchors.topMargin: 12
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.fillRect(0,0,drawingCanvas.width ,drawingCanvas.height )

                    ctx.lineWidth = 1;
                    ctx.strokeStyle = "green"
                    ctx.beginPath()
                   /* ctx.moveTo(271, 300)
                    ctx.lineTo(271, 700)


                    ctx.moveTo(752, 300)
                    ctx.lineTo(752, 700)*/

                    ctx.moveTo(380, 408)
                    ctx.lineTo(650, 408)

                    ctx.moveTo(380, 560)
                    ctx.lineTo(650, 560)
                    //ctx.closePath()
                    ctx.stroke()
                }
            }




    Rectangle {
        id: rectangle

        y: 107
        width: 481
        height: 81
        color: "lightblue"
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    Text {
        id: element
        x: 19
        y: 24
        text: qsTr("HE THONG PHONG CHAY CHUA CHAY")
        font.pixelSize: 26
    }
    }





        PrimaryButton{
        id: thuNghiem
        x: 137
        y: 302
        z: 1
        text: "Tien hanh thu nghiem"
        anchors.horizontalCenterOffset: 1

        anchors.horizontalCenter: parent.horizontalCenter

        }


        PrimaryButton{
        id: thuNghiemBangTay
        text: "Thu nghiem bang tay"
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
        y: 453
        z: 1
        MouseArea {
          anchors.fill: parent
          onClicked: stack.push("BangTay.qml")
      }
        }

        PrimaryButton{
            id: caidatButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: 609
            z: 1
            text: "Cai dat"
            anchors.horizontalCenterOffset: 1

              MouseArea {
                anchors.fill: parent
            onClicked: stack.push("Caidat.qml")
            }
              Image {
                  id: name
                  anchors.left:  parent.left
                  width: parent.width/3
                  height: parent.height
              }

        }




}
