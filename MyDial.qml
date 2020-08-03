import QtQuick 2.0
import QtQuick.Controls 2.0
Item {

    scale: 0.7
    visible: true
    signal movedMyDial(real xvalue)
    Dial {
        id:control

        x: 70
        y: 38
        scale: 1
        rotation: 0
        background: Image {
            width: parent.width
              height: parent.height
              source: "./Icon/gauge-md.png"

            }
        wrap: true
         handle: Image {
                    id: handleItem
                    x: 31
                    y: 28
                    scale: 0.71
                    rotation: -140
                    visible: true

                    source: "./Icon/needle.png"


                    transform: [
                        Translate {
                            y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
                        },
                        Rotation {
                            angle: control.angle
                            origin.x: handleItem.width / 2
                            origin.y: handleItem.height / 2
                        }
                    ]
                }
         onMoved: control.movedMyDial(control.value)
       }
}
