package com.glu.platform.android;

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Vibrator;
import java.io.File;
import java.io.FileInputStream;

/* JADX INFO: loaded from: classes.dex */
public final class DeviceSound {
    public static DeviceSound instance = null;
    public AudioManager m_audioManager;
    public boolean m_oemAudioPlaying;
    public int m_oemAudioVolume;
    public Vibrator vibrator;
    private DeviceTrack m_audioTrack = null;
    private int bytesWritten = 0;
    public byte[] m_audioData = null;
    public byte[] m_emptyData = null;
    public boolean m_soundForcedByUser = false;
    private int m_nativeBitRate = -1;
    private int m_nativeNumChannels = -1;
    private int m_nativeFrequency = -1;
    private int m_pcmVolumeZeroToTen = 5;
    private MediaPlayer m_ourMP3 = null;
    private String m_lastSoundPlayed = null;
    private boolean m_mp3IsPaused = false;
    private boolean m_mp3Enabled = true;
    private float m_leftVolume = 0.5f;
    private float m_rightVolume = 0.5f;
    private boolean m_lowerGameAudioForPrioritySource = false;
    public ManualAudioTrackNotifier m_manualNotifierThread = null;

    public class ManualAudioTrackNotifier extends Thread {
        public boolean m_matnRunning;

        @Override // java.lang.Thread, java.lang.Runnable
        public final void run() {
            System.currentTimeMillis();
            while (this.m_matnRunning && GluPlatformActivity.instance != null) {
                try {
                    Thread.sleep(40L);
                } catch (Exception e) {
                    String str = "Sleep for 40ms interrupted...somehow.";
                }
            }
        }

        public final void wrapUp() {
            this.m_matnRunning = false;
        }
    }

    public DeviceSound() {
        this.vibrator = null;
        this.m_audioManager = null;
        this.m_oemAudioPlaying = false;
        this.m_oemAudioVolume = 0;
        instance = this;
        if (this.vibrator == null) {
            this.vibrator = (Vibrator) GluPlatformActivity.instance.getSystemService("vibrator");
        }
        if (this.m_audioManager == null) {
            this.m_audioManager = (AudioManager) GluPlatformActivity.instance.getSystemService("audio");
        }
        this.m_oemAudioPlaying = instance.m_audioManager.isMusicActive();
        if (this.m_oemAudioPlaying) {
            this.m_oemAudioVolume = instance.m_audioManager.getStreamVolume(3);
        }
    }

    public final void pauseMP3() {
        if (this.m_ourMP3 == null || this.m_mp3IsPaused) {
            return;
        }
        this.m_ourMP3.pause();
        this.m_mp3IsPaused = true;
    }

    public final void playMP3(String str, boolean z) {
        if (!instance.m_oemAudioPlaying || this.m_soundForcedByUser) {
            String str2 = this.m_lastSoundPlayed;
            if (str2 == null) {
                str2 = "null";
            }
            if (!str2.equals(str) || this.m_ourMP3 == null) {
                if (!this.m_mp3Enabled) {
                    return;
                }
            } else if (this.m_ourMP3.isPlaying()) {
                return;
            }
            stopAndDestroyMP3();
            File fileFindMediaResourceFile = GluUtil.findMediaResourceFile(str);
            if (fileFindMediaResourceFile != null) {
                try {
                    FileInputStream fileInputStream = new FileInputStream(fileFindMediaResourceFile);
                    this.m_ourMP3 = new MediaPlayer();
                    this.m_ourMP3.setDataSource(fileInputStream.getFD());
                    this.m_ourMP3.prepare();
                    this.m_ourMP3.setLooping(z);
                    this.m_ourMP3.setVolume(this.m_leftVolume, this.m_rightVolume);
                    this.m_ourMP3.start();
                    this.m_lastSoundPlayed = str;
                } catch (Exception e) {
                    this.m_ourMP3 = null;
                    this.m_lastSoundPlayed = null;
                }
            }
        }
    }

    public final void resumeMP3() {
        if (this.m_ourMP3 == null) {
            this.m_mp3IsPaused = false;
        } else if (this.m_mp3Enabled && this.m_mp3IsPaused) {
            this.m_ourMP3.start();
            this.m_mp3IsPaused = false;
        }
    }

    public final void stop() {
        pauseMP3();
        this.m_mp3Enabled = false;
        if (this.m_audioTrack == null) {
            return;
        }
        this.m_audioTrack.stop();
        if (this.m_manualNotifierThread != null) {
            this.m_manualNotifierThread.wrapUp();
            this.m_manualNotifierThread = null;
        }
        this.m_audioTrack = null;
    }

    public final void stopAndDestroyMP3() {
        if (this.m_ourMP3 == null) {
            this.m_mp3IsPaused = false;
            return;
        }
        this.m_ourMP3.stop();
        this.m_ourMP3.release();
        this.m_ourMP3 = null;
    }

    public final void volumeSetMP3(int i) {
        float f = i / 100.0f;
        this.m_rightVolume = f;
        this.m_leftVolume = f;
        if (this.m_leftVolume < 0.0f) {
            this.m_leftVolume = 0.0f;
        } else if (this.m_leftVolume > 1.0f) {
            this.m_leftVolume = 1.0f;
        }
        if (this.m_rightVolume < 0.0f) {
            this.m_rightVolume = 0.0f;
        } else if (this.m_rightVolume > 1.0f) {
            this.m_rightVolume = 1.0f;
        }
        if (this.m_ourMP3 != null) {
            if (this.m_lowerGameAudioForPrioritySource) {
                this.m_ourMP3.setVolume(this.m_leftVolume <= 0.0f ? 0.0f : 0.1f, this.m_rightVolume > 0.0f ? 0.1f : 0.0f);
            } else {
                this.m_ourMP3.setVolume(this.m_leftVolume, this.m_rightVolume);
            }
        }
    }
}
