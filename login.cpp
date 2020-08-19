#include "login.hpp"

Login::Login(){
    network = new Network();
}

void Login::onClick(QString userName,QString password)
{
    this->settings->setUserName(userName);
    this->settings->setPassword(password);
    network->login(userName, password);
    connect(network->reply, &QNetworkReply::finished, [=]() {
        if(network->reply->error() == QNetworkReply::NoError){
            QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
            if (obj.value("code").toInt() == 0){
                settings->setToken(obj.value("data").toObject().value("token").toString());
                emit loginSuccess();
            } else {
                emit loginFailed();
            }
        } else {
            settings->setToken("");
            logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
            emit loginFailed();
        }
    });
}

QString Login::loggedUsername()
{
    return settings->getUserName();
}

QString Login::loggedPassword()
{
    return settings->getPassword();
}

bool Login::logged()
{
    return settings->getToken() != "";
}
