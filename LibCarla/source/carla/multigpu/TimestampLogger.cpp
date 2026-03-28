#include "TimestampLogger.h"
#include <chrono>
#include <iomanip>

TimestampLogger::TimestampLogger() : header_written_(false) {
    log_file_.open("/home/janice/carla/carla_timestamps.csv", std::ios::out | std::ios::app);
    if (log_file_.is_open()) {
        log_file_ << "Frame,Timestamp,Event,Agent type\n";  // Write header once
        header_written_ = true;
    }
}

TimestampLogger::~TimestampLogger() {
    if (log_file_.is_open()) {
        log_file_.close();
    }
}

TimestampLogger& TimestampLogger::GetInstance() {
    static TimestampLogger instance;
    return instance;
}

void TimestampLogger::Log(const std::string& event, double timestamp, int frame) {
    std::lock_guard<std::mutex> lock(log_mutex_);
    if (log_file_.is_open()) {
        log_file_ << frame << "," << std::fixed << timestamp << "," << event << "," << "server" << "\n";
    }
}