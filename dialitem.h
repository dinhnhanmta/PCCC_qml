#ifndef DIALITEM_H
#define DIALITEM_H

#include <QQuickPaintedItem>

class DialItem : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(int startValue READ getStartValue WRITE setStartValue NOTIFY startValueChanged)
    Q_PROPERTY(int stopValue READ getStopValue WRITE setStopValue NOTIFY stopValueChanged)
    Q_PROPERTY(int startAngle READ getStartAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(qreal spanAngle READ getSpanAngle WRITE setSpanAngle NOTIFY spanAngleChanged)
    Q_PROPERTY(int dialWidth READ getDialWidth WRITE setDialWidth NOTIFY dialWidthChanged)
    Q_PROPERTY(QColor dialColor READ getDialColor WRITE setDialColor NOTIFY dialColorChanged)


public:
    DialItem(QQuickItem *parent = 0);
    void paint(QPainter *painter);

    int getStartAngle() {return m_StartAngle;}
    qreal getSpanAngle() {return m_SpanAngle;}
    int getDialWidth() {return m_DialWidth;}
    QColor getDialColor() {return m_DialColor;}

    int getStartValue() {return m_StartValue;}
    int getStopValue() {return m_StopValue;}

    void setStartAngle(int angle) {m_StartAngle = angle; this->update();}
    void setSpanAngle(qreal angle) {m_SpanAngle = angle; this->update();}
    void setDialWidth(int angle) {m_DialWidth = angle; this->update();}
    void setDialColor(QColor color) {m_DialColor = color; this->update();}

    void setStartValue(int angle) {m_StartValue = angle; this->update();}
    void setStopValue(int angle) {m_StopValue = angle; this->update();}

signals:
    void startAngleChanged();
    void spanAngleChanged();
    void dialWidthChanged();
    void dialColorChanged();
    void startValueChanged();
    void stopValueChanged();

public slots:

private:
    int m_StartAngle;
    int m_StartValue;
    int m_StopValue;
    qreal m_SpanAngle;
    int m_DialWidth;
    QColor m_DialColor;
};

#endif // DIALITEM_H
