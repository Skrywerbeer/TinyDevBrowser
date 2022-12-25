#include <QCoreApplication>

#include <QGuiApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>

using namespace std;

int main(int argc, char **argv) {
	QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
	QGuiApplication app(argc, argv);
//	QQuickView view;
	QQmlApplicationEngine engine("qrc:/tinyDevBrowser/main.qml");
//	view.setSource(QUrl("qrc:/tinyDevBrowser/main.qml"));
//	view.connect(&view, &QQuickView::statusChanged, [&] {
//		qDebug() << view.errors();
//	});

//	view.show();

	return app.exec();
}
