#include <QAbstractListModel>

class ListDeviceModels : public QAbstractListModel
{
    Q_OBJECT
public:

    ListDeviceModels(const QStringList &deviceModels, QObject *parent = 0)
            : QAbstractListModel(parent), m_list(deviceModels) {}

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;

    int columnCount(const QModelIndex &parent = QModelIndex()) const;
private:
    QStringList m_list;

};
