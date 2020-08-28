/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Charts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtCharts 2.0
import camBienApSuat 1.0
import QtQml 2.0
Item {
    width: 700
    height: 450
    property int test : 45;
    property string thu : "??";
    property var pThu: []
    property var xValue: []
    Chart{
        id :chartID
        width: 700
        height: 450

        onPaint: {

            line({
                     labels : xValue,
                     datasets : [
                         {
                             fillColor : "rgba(220,220,220,0.5)",
                             strokeColor : "rgba(220,220,220,1)",
                             pointColor : "rgba(220,220,220,1)",
                             pointStrokeColor : "#fff",
                             data : someList
                         },
                         {
                             fillColor : "rgba(151,187,205,0.5)",
                             strokeColor : "rgba(151,187,205,1)",
                             pointColor : "rgba(151,187,205,1)",
                             pointStrokeColor : "#fff",
                             data : [28,48,40,19,96,27,100]
                         }
                     ],
                 });


       }

    }

    Timer{
        id:t
        interval: 1000
        repeat: true
        running: true
        onTriggered:{
            var d = new Date()
            thu = d.getSeconds() + ":" + d. getMilliseconds()
            xValue.push(thu)
            someList.push(44)
            chartID.requestPaint();
        }
    }
        Component.onCompleted: {
            console.debug("this is the chart.js by qml you can use it just like use the chart.js ",
                          "you can look the Chart.js in http://chartjs.org/");
            thu="qeqef"
            requestPaint()
        }






    CamBienApSuat {
        onPressureChanged:
        {
            axisX.min = axisX.min + 1
            axisX.max = axisX.max + 1
            var count = series1.count
            series1.remove(0);
            series1.insert(count,axisX.max-1,Cambien.q_pressure);
            var xValue = d.getMinutes() + ":" + d.getSeconds() + ":"+d.getMilliseconds()
        }
    }
}
