#
# Options (select one audio driver and one midi driver)
#

# PortAudio (Working good. Linux OSS, Windows, MacOS X)
SOURCES += playerportaudio.cpp
HEADERS += playerportaudio.h
DEFINES += __PORTAUDIO__
unix:!macx:SOURCES += ../lib/portaudio-v18/pa_lib.c ../lib/portaudio-v18/pa_convert.c ../lib/portaudio-v18/pa_unix_oss.c
unix:!macx:HEADERS += ../lib/portaudio-v18/portaudio.h ../lib/portaudio-v18/pa_host.h
win32:SOURCES += ../lib/portaudio-v18/pa_lib.c ../lib/portaudio-v18/dsound_wrapper.c ../lib/portaudio-v18/pa_dsound.c
win32:HEADERS += ../lib/portaudio-v18/portaudio.h ../lib/portaudio-v18/pa_host.h
win32:LIBS += dsound.lib
macx:SOURCES += ../lib/portaudio-v18mac/ringbuffer.c ../lib/portaudio-v18mac/pa_lib.c ../lib/portaudio-v18mac/pa_mac_core.c ../lib/portaudio-v18mac/pa_convert.c
macx:HEADERS += ../lib/portaudio-v18mac/ringbuffer.h ../lib/portaudio-v18mac/portaudio.h ../lib/portaudio-v18mac/pa_host.h
macx:LIBS += -framework CoreAudio -framework AudioToolbox
macx:INCLUDEPATH += ../lib/portaudio-v18mac

# OSS Midi (Working good, Linux specific)
unix:!macx:SOURCES += midiobjectoss.cpp
unix:!macx:HEADERS += midiobjectoss.h
unix:!macx:DEFINES += __OSSMIDI__

# Windows MIDI
win32:SOURCES += midiobjectwin.cpp
win32:HEADERS += midiobjectwin.h
win32:DEFINES += __WINMIDI__

# PortMidi (Not really working, Linux ALSA, Windows and MacOS X)
#SOURCES += midiobjectportmidi.cpp
#HEADERS += midiobjectportmidi.h
#DEFINES += __PORTMIDI__
#unix:LIBS += -lportmidi -lporttime
#win32:LIBS += ../lib/pm_dll.lib

# CoreMidi (Mac OS X)
macx:SOURCES += midiobjectcoremidi.cpp
macx:HEADERS += midiobjectcoremidi.h
macx:DEFINES += __COREMIDI__
macx:LIBS    += -framework CoreMIDI -framework CoreFoundation

# ALSA PCM (Not currently working, Linux specific)
#SOURCES += playeralsa.cpp
#HEADERS += playeralsa.h
#DEFINES += __ALSA__
#unix:LIBS += -lasound

# ALSA MIDI (Not currently working, Linux specific)
#SOURCES += midiobjectalsa.cpp
#HEADERS += midiobjectalsa.h
#DEFINES  += __ALSAMIDI__

# Visuals
# SOURCES += mixxxvisual.cpp visual/visualbackplane.cpp visual/texture.cpp visual/guicontainer.cpp visual/buffer.cpp visual/box.cpp visual/controller.cpp visual/guisignal.cpp visual/light.cpp visual/material.cpp visual/pick.cpp visual/pickable.cpp visual/signal.cpp visual/visual.cpp visual/fastvertexarray.cpp
# HEADERS += mixxxvisual.h visual/visualbackplane.h  visual/texture.h visual/guicontainer.h visual/buffer.h visual/box.h visual/controller.h visual/guisignal.h visual/light.h visual/material.h visual/pick.h visual/pickable.h visual/signal.h visual/visual.h visual/fastvertexarray.h
# CONFIG += opengl
# DEFINES += __VISUALS__

# Use NVSDK when building
#DEFINES += __NVSDK__
#win32:INCLUDEPATH += c:/Progra~1/NVIDIA~1/NVSDK/OpenGL/include/glh
#win32:LIBS += c:/Progra~1/NVIDIA~1/NVSDK/OpenGL/lib/debug/glut32.lib
#unix:INCLUDEPATH +=/usr/local/nvsdk/OpenGL/include/glh
#unix:DEFINES += UNIX
#unix:LIBS += -L/usr/local/nvsdk/OpenGL/lib/ -lnv_memory

#
# End of options
#

SOURCES	+= configobject.cpp fakemonitor.cpp controllogpotmeter.cpp controlobject.cpp controlnull.cpp controlpotmeter.cpp controlpushbutton.cpp controlrotary.cpp controlttrotary.cpp dlgchannel.cpp dlgplaycontrol.cpp dlgplaylist.cpp dlgmaster.cpp dlgcrossfader.cpp dlgsplit.cpp dlgpreferences.cpp dlgflanger.cpp enginebuffer.cpp engineclipping.cpp enginefilterblock.cpp enginefilteriir.cpp engineobject.cpp enginepregain.cpp enginevolume.cpp main.cpp midiobject.cpp midiobjectnull.cpp mixxx.cpp mixxxdoc.cpp mixxxview.cpp player.cpp soundsource.cpp soundsourcemp3.cpp monitor.cpp enginechannel.cpp enginemaster.cpp wknob.cpp wbulb.cpp wplaybutton.cpp wwheel.cpp wslider.cpp wpflbutton.cpp wplayposslider.cpp enginedelay.cpp engineflanger.cpp enginepreprocess.cpp enginespectralfwd.cpp enginespectralback.cpp mathstuff.cpp soundbuffer.cpp rtthread.cpp windowkaiser.cpp
HEADERS	+= configobject.h fakemonitor.h controllogpotmeter.h controlobject.h controlnull.h controlpotmeter.h controlpushbutton.h controlrotary.h controlttrotary.h defs.h dlgchannel.h dlgplaycontrol.h dlgplaylist.h dlgmaster.h dlgcrossfader.h dlgsplit.h dlgpreferences.h dlgflanger.h enginebuffer.h engineclipping.h enginefilterblock.h enginefilteriir.h engineobject.h enginepregain.h enginevolume.h midiobject.h midiobjectnull.h mixxx.h mixxxdoc.h mixxxview.h player.h soundsource.h soundsourcemp3.h monitor.h enginechannel.h enginemaster.h wknob.h wbulb.h wplaybutton.h wwheel.h wslider.h wpflbutton.h wplayposslider.h enginedelay.h engineflanger.h enginepreprocess.h enginespectralfwd.h enginespectralback.h mathstuff.h soundbuffer.h rtthread.h windowkaiser.h

unix {
  DEFINES += __UNIX__
  UI_DIR = .ui
  MOC_DIR = .moc
  OBJECTS_DIR = .obj
  SOURCES += soundsourceaudiofile.cpp
  HEADERS += soundsourceaudiofile.h
  LIBS += -lmad #/usr/local/lib/libmad.a 
  !macx:LIBS += -laudiofile #/usr/lib/libaudiofile.a
  LIBS += -lsrfftw -lsfftw
  INCLUDEPATH += .
#  Intel Compiler optimization flags
#  QMAKE_CXXFLAGS += -rcd -tpp6 -xiMK # icc pentium III
#  QMAKE_CXXFLAGS += -rcd -tpp7 -xiMKW # icc pentium IV 
#  QMAKE_CXXFLAGS += -prof_use #-genx # icc profiling
  !macx:CONFIG_PATH = \"/usr/share/mixxx\"
}

win32 {
  DEFINES += __WIN__
  INCLUDEPATH += ../winlib ../lib/portaudio-v18 .
  SOURCES += soundsourcesndfile.cpp
  HEADERS += soundsourcesndfile.h
  LIBS += ../winlib/libmad.lib ../winlib/libsndfile.lib
  QMAKE_CXXFLAGS += -GX
  QMAKE_LFLAGS += /NODEFAULTLIB:libcd /NODEFAULTLIB:libcmtd 
  #/NODEFAULTLIB:msvcrt.lib 
  CONFIG_PATH = \"config\"
}

macx {
  DEFINES += __MACX__
  LIBS += /usr/local/lib/libaudiofile.a -lz -framework Carbon -framework QuickTime
  CONFIG_PATH = \"./Contents/Resources/config/\" 
}

# gcc Profiling
#unix:QMAKE_CXXFLAGS_DEBUG += -pg
#unix:QMAKE_LFLAGS_DEBUG += -pg

DEFINES += CONFIG_PATH=$$CONFIG_PATH
FORMS	= dlgchanneldlg.ui dlgplaycontroldlg.ui dlgplaylistdlg.ui dlgmasterdlg.ui dlgcrossfaderdlg.ui dlgsplitdlg.ui dlgpreferencesdlg.ui dlgflangerdlg.ui
IMAGES	= filesave.xpm
unix:TEMPLATE         = app
win32:TEMPLATE       = vcapp
CONFIG	+= qt warn_on thread debug 
DBFILE	= mixxx.db
LANGUAGE	= C++
