#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif
#include <QtQml> // needed for registering AudioRecorder
#include <QGuiApplication>
#include <QLocale>
#include <QQuickView>
#include <QScopedPointer>
#include <QStandardPaths>
#include <auroraapp.h>
#include "audio-recorder.h"

int main(int argc, char *argv[])
{
    // For vendored python to work
    qputenv("PYTHONHOME", QString("/usr/share/moe.smoothie.videoworks/").toUtf8().constData());

    // For vendored binaries to be easily accessible
    QString oldPath = QString::fromLocal8Bit(qgetenv("PATH"));
    QString newPath = "/usr/libexec/moe.smoothie.videoworks:" + oldPath;
    qputenv("PATH", newPath.toUtf8().constData());
    qDebug() << "Set the path variable to" << newPath; 

    QGuiApplication *app = Aurora::Application::application(argc, argv);
    app->setOrganizationName("moe.smoothie");
    app->setApplicationName("videoworks");
    
    qmlRegisterType<AudioRecorder>("AudioRecorder", 1, 0, "AudioRecorder");
    
    QScopedPointer<QQuickView> view(Aurora::Application::createView());

    // Vendored pyotherside
    view->engine()->addImportPath(Aurora::Application::pathTo("lib/qt5/qml").toString());

    view->setSource(Aurora::Application::pathToMainQml());
    view->setTitle("Videoworks");
    view->showFullScreen();
    return app->exec();
}
