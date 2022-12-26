#ifndef FILECHANGEMONITOR_H
#define FILECHANGEMONITOR_H

#include <QObject>
#include <QDir>
#include <QDateTime>
#include <QHash>
#include <QtQml/qqmlregistration.h>

#include <stdexcept>

class FileChangeMonitor : public QObject {
		Q_OBJECT
		Q_PROPERTY(int interval
		           READ interval
		           WRITE setInterval
		           NOTIFY intervalChanged)
		Q_PROPERTY(bool running
		           READ running
		           WRITE setRunning
		           NOTIFY runningChanged)
		Q_PROPERTY(QString path
		           READ path
		           WRITE setPath
		           NOTIFY pathChanged)
		QML_ELEMENT
	public:
		explicit FileChangeMonitor(QObject *parent = nullptr);

		int interval() const;
		void setInterval(const int &value);
		bool running() const;
		void setRunning(const bool &value);
		QString path() const;
		void setPath(const QString &path);


		// QAbstractListModel methods.

	signals:
		void filesChanged();
		void intervalChanged();
		void runningChanged();
		void pathChanged();

	protected:
		void timerEvent(QTimerEvent *event) override;

	private:
		int _interval = 1000;
		bool _running = false;
		// TODO: add selectable filters.
		const QStringList _filters{"*.html", "*.css", "*.js"};
		QDir _directory;
		QHash<QString, QDateTime> _timestamps;

		int _timerID = 0;

		void startChangeTimer();
		void stopChangeTimer();
		void adjustTimerToState();

		// Populates _timestamps with entries from _directory.
		void populateTimestamps();
		// Removes all entries from _timestamps.
		void clearTimestamps();
		// Iterate over _timestamps, compare saved modified time with the file's
		// current last modified. If a file has been modified return true.
		bool checkTimestamps();
};

#endif // FILECHANGEMONITOR_H
