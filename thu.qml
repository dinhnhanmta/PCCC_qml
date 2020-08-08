import QtQuick 2.0
import QtCharts 2.0

Item {
    anchors.fill: parent

    property double startTime: 0

    ChartView {
        title: startTime
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        ValueAxis {
            id: axisX
            min: 0
            max: 10
            tickCount: 5
        }

        ValueAxis {
            id: axisY1
            min: -0.5
            max: 1.5
        }
        ValueAxis {
            id: axisY2
            min: 0
            max: 1000
        }

        SplineSeries {
            id: series1
            axisX: axisX
            axisY: axisY1
        }

        SplineSeries {
            id: series2
            axisX: axisX
            axisY: axisY2
        }
    }

    // Add data dynamically to the series
    Timer{
        property int amountOfData: 0 //So we know when we need to start scrolling
        id: refreshTimer
        interval: 25
        running: true
        repeat: true
        onTriggered: {
            series1.append(2, Dashboard.gpsSpeed);
            series2.append(10, Dashboard.gpsAltitude);

            if(amountOfData > axisX.max){
                axisX.min++;
                axisX.max++;
            }else{
                amountOfData++; //This else is just to stop incrementing the variable unnecessarily
            }
        }
    }

}
