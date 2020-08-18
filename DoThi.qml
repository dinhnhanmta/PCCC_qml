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
Item {
    width: 500
    height: 300

    //![1]
    ChartView {
        title: "Two Series, Common Axes"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        legend.alignment: Qt.AlignTop
        animationOptions: ChartView.SeriesAnimations

        ValueAxis {
            id: axisX
            min: 0
            max: 20
            tickCount: 11
        }

        ValueAxis {
            id: axisY
            min: 0
            max: 25
        }

        LineSeries {
            id: series1
            axisX: axisX
            axisY: axisY
        }
    }

    Component.onCompleted: {
        for (var i = 0; i <= 19; i++) {
            series1.append(i, 0);
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
        }
    }

    /*
       Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: {
                axisX.min = axisX.min + 1
                axisX.max = axisX.max + 1
                var count = series1.count
                series1.remove(0);
                series1.insert(count,axisX.max-1,Cambien.q_pressure);
            }
        }
        */

}
