#include "filechangemonitor.h"

FileChangeMonitor::FileChangeMonitor(QObject *parent)
    : QObject{parent} {}

int FileChangeMonitor::interval() const {
	return _interval;
}

void FileChangeMonitor::setInterval(const int &value) {
	if (value == _interval)
		return;
	_interval = value;
	adjustTimerToState();
	emit intervalChanged();
}

bool FileChangeMonitor::running() const {
	return _running;
}

void FileChangeMonitor::setRunning(const bool &value) {
	if (value == _running)
		return;
	_running = value;
	adjustTimerToState();
	emit runningChanged();
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
	_directory = dir;
	clearTimestamps();
	populateTimestamps();
	emit pathChanged();
}

void FileChangeMonitor::timerEvent(QTimerEvent *event) {
	Q_UNUSED(event);
	if (checkTimestamps())
		emit filesChanged();
}

void FileChangeMonitor::startChangeTimer() {
	if (_timerID) {
		killTimer(_timerID);
		_timerID = startTimer(_interval);
	}
	else {
		_timerID = startTimer(_interval);
	}
}

void FileChangeMonitor::stopChangeTimer() {
	Q_ASSERT(_timerID);
	killTimer(_timerID);
	_timerID = 0;
}

void FileChangeMonitor::adjustTimerToState() {
	if (_running)
		startChangeTimer();
	else
		stopChangeTimer();
}

void FileChangeMonitor::populateTimestamps() {
	for (const auto &file : _directory.entryInfoList(_filters))
		_timestamps[file.fileName()] = file.lastModified();
}

void FileChangeMonitor::clearTimestamps() {
	_timestamps.clear();
}

bool FileChangeMonitor::checkTimestamps() {
	for (const auto &file : _directory.entryInfoList(_filters)) {
		if (_timestamps.value(file.fileName()) != file.lastModified()) {
			_timestamps[file.fileName()] = file.lastModified();
			return true;
		}
	}
	return false;
}
