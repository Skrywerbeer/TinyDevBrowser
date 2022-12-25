#ifndef FILECHANGEMONITOR_H
#define FILECHANGEMONITOR_H

#include <QObject>
#include <QDir>
#include <QDateTime>
#include <QtQml/qqmlregistration.h>

#include <stdexcept>

class FileChangeMonitor : public QObject {
		Q_OBJECT
		Q_PROPERTY(int interval
		           READ interval
		           WRITE setInterval
		           NOTIFY intervalChanged)
		Q_PROPERTY(bool run
		           READ run
		           WRITE setRun
		           NOTIFY runChanged)
		Q_PROPERTY(QString path
		           READ path
		           WRITE setPath
		           NOTIFY pathChanged)
		QML_ELEMENT
	public:
		explicit FileChangeMonitor(QObject *parent = nullptr);

		int interval() const;
		void setInterval(const int &value);
		bool run() const;
		void setRun(const bool &value);
		QString path() const;
		void setPath(const QString &path);


		// QAbstractListModel methods.

	signals:
		void monitoredFileChanged();
		void intervalChanged();
		void runChanged();
		void pathChanged();

	private:
		int _interval = 1000;
		bool _run = false;
		QDir _directory;
		int _timestamp = 0;

		void sortFiles();
};

#endif // FILECHANGEMONITOR_H
