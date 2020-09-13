#ifndef DOTHI_H
#define DOTHI_H
#include <QtCharts/QChartView>
#include <QLineSeries>
#include <QtCharts/QCategoryAxis>

QT_CHARTS_USE_NAMESPACE
class Dothi: public QObject {
    Q_OBJECT

public:
    Dothi();

private:
    QLineSeries *series;
    QChart *chart;
    QCategoryAxis *axisY;
    QCategoryAxis *axisX;
    QChartView *chartView;
};

#endif // DOTHI_H
