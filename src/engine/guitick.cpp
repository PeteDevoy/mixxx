#include <QTimer>

#include "engine/guitick.h"
#include "controlobject.h"


// static
double GuiTick::m_streamTime = 0.0;
double GuiTick::m_cpuTime = 0.0;

GuiTick::GuiTick(QObject* pParent)
        : QObject(pParent),
          m_lastUpdateTime(0.0) {
     m_pCOStreamTime = new ControlObject(ConfigKey("[Master]", "streamTime"));
     m_pCOCpuTime = new ControlObject(ConfigKey("[Master]", "cpuTime"));
     m_pCOGuiTick50ms = new ControlObject(ConfigKey("[Master]", "guiTick50ms"));
     m_cpuTimer.start();

     m_backupTimer = new QTimer(this);
     connect(m_backupTimer, SIGNAL(timeout()), this, SLOT(slotBackupTimerExpired()));
     m_backupTimer->setSingleShot(true);
     m_backupTimer->start(100);
}

GuiTick::~GuiTick() {
    delete m_pCOStreamTime;
    delete m_pCOGuiTick50ms;
}

void GuiTick::process() {
    qint64 elapsedNs = m_cpuTimer.restart();
    double elapsedS = elapsedNs / 1000000000.0;
    m_cpuTime += elapsedS;
    m_pCOCpuTime->set(m_cpuTime);

    if (m_lastUpdateTime + 0.05 < m_cpuTime) {
        m_lastUpdateTime = m_cpuTime;
        m_pCOGuiTick50ms->set(m_streamTime);
    }

    m_pCOStreamTime->set(m_streamTime);

    // Start backuptimer just in case there is no audio callback.
    // Normally this should not happen, because Qt tries best to deliver the
    // timeout() signal in time. But since this does not yield the waveform
    // renderere timer, it is not want we need for this non real-time GUI tick
    m_backupTimer->start(100);
}

// static
void GuiTick::setStreamTime(double streamTime) {
    m_streamTime = streamTime;
}

// static
double GuiTick::streamTime() {
    return m_streamTime;
}

// static
double GuiTick::cpuTime() {
    return m_cpuTime;
}

void GuiTick::slotBackupTimerExpired() {
    //qDebug() << "GuiTick::slotBackupTimerExpired()";
    process();
}


