#include "filechangemonitor.h"

FileChangeMonitor::FileChangeMonitor(QObject *parent)
    : QObject{parent} {

}

int FileChangeMonitor::interval() const {
	return _interval;
}

void FileChangeMonitor::setInterval(const int &value) {
	if (value == _interval)
		return;
	_interval = value;
	emit intervalChanged();
}

bool FileChangeMonitor::run() const {
	return _run;
}

void FileChangeMonitor::setRun(const bool &value) {
	if (value == _run)
		return;
	_run = value;
	emit runChanged();
}

QString FileChangeMonitor::path() const {
	return _directory.path();
}

void FileChangeMonitor::setPath(const QString &path) {
	if (path == _directory.path())
		return;
	QDir dir(path);
	if (!dir.exists())
		throw std::runtime_error(
	            QString("Directory \"%1\" does not exist").arg(path).toStdString());

}
