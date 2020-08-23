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

    //![1]
    ChartView {
        title: qsTr("ĐỒ THỊ ÁP SUẤT THEO THỜI GIAN")
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        legend.alignment: Qt.AlignTop
        animationOptions: ChartView.SeriesAnimations
        LineSeries {
               id: series1
                axisX: DateTimeAxis {

                    tickCount: 5
                }
                axisY: ValueAxis {
                    min: 0
                    max: 25
                }
    }

    Component.onCompleted: {
        var d = new Date()
        var xValue = d.getMinutes() + ":" + d.getSeconds() //+ ":"+d.getMilliseconds()
        var d2= new Date()

        var locale =  Qt.locale()
         var dateTimeString = "Tue 2013-09-17 10:56:06"
        console.log(Date.fromLocaleString(locale, dateTimeString, "ddd yyyy-MM-dd hh:mm:ss"));
       // console.log (d2)
        for (var i = -5; i <= 0; i++) {
            series1.append(d2,10);
        }

    }
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
