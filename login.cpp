#include "localdatabase.h"
#include "login.hpp"

Login::Login(){
    network = new Network();
}

void Login::onClick(QString userName,QString password)
{
    settings->defautConfig.setUserName(userName);
    settings->defautConfig.setPassword(password);
    network->login(userName, password);
    connect(network->reply, &QNetworkReply::finished, [=]() {
        if(network->reply->error() == QNetworkReply::NoError){
            QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
            if (obj.value("code").toInt() == 200){
                settings->defautConfig.setToken(obj.value("data").toObject().value("token").toString());
                emit loginSuccess();
            } else {
                emit loginFailed();
            }
        } else {
            settings->defautConfig.setToken("");
            logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
            emit loginFailed();
        }
    });
}

void Login::onClick(){
    emit loginSuccess();
}

QString Login::loggedUsername()
{
    return settings->defautConfig.getUserName();
}

QString Login::loggedPassword()
{
    return settings->defautConfig.getPassword();
}

bool Login::logged()
{
    return !settings->defautConfig.getToken().isEmpty();
}

void Login::logout()
{
    settings->defautConfig.setToken("");
}
