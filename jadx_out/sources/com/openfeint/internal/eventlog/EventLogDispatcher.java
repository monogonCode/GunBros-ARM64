package com.openfeint.internal.eventlog;

import com.openfeint.internal.logcat.OFLog;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class EventLogDispatcher {
    private static EventLogDispatcher instance;
    private Map<String, Map<String, IEventListener>> subscription = new HashMap();

    private EventLogDispatcher() {
    }

    public static EventLogDispatcher getInstance() {
        if (instance == null) {
            instance = new EventLogDispatcher();
        }
        return instance;
    }

    public final void postEvent(String str, Object obj) {
        if (this.subscription.containsKey(str)) {
            Map<String, IEventListener> map = this.subscription.get(str);
            Iterator<String> it = map.keySet().iterator();
            while (it.hasNext()) {
                IEventListener iEventListener = map.get(it.next());
                OFLog.d("EventLogDispatcher", "posteEvent:" + str + " to listener: " + iEventListener.getName());
                iEventListener.handleEvent(str, obj);
            }
        }
    }

    public final boolean subscribe(String str, IEventListener iEventListener) {
        if (iEventListener == null || iEventListener.getName() == null || str == null) {
            return false;
        }
        OFLog.d("EventLogDispatcher", "subscribe:" + str + " from: " + iEventListener.getName());
        Map<String, IEventListener> map = this.subscription.get(str);
        if (map == null) {
            map = new HashMap<>();
            map.put(iEventListener.getName(), iEventListener);
        } else {
            map.put(iEventListener.getName(), iEventListener);
        }
        this.subscription.put(str, map);
        return true;
    }
}
