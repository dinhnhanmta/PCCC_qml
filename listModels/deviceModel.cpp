#include <QVariant>
#include "deviceModel.h"
#include <QDebug>
QVariant ListDeviceModels::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() >= m_list.size())
        return QVariant();

    if (role == Qt::DisplayRole)
        return m_list.at(index.row());
    else
        return QVariant();
}

int ListDeviceModels::rowCount(const QModelIndex &parent) const
{
    return m_list.count();
}

int ListDeviceModels::columnCount(const QModelIndex& parent) const
{
   return 1;
}
