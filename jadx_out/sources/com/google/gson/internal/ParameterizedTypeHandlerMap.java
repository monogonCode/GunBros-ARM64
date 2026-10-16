package com.google.gson.internal;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/* JADX INFO: loaded from: classes.dex */
public final class ParameterizedTypeHandlerMap<T> {
    private static final Logger logger = Logger.getLogger(ParameterizedTypeHandlerMap.class.getName());
    private final Map<Type, T> systemMap = new HashMap();
    private final Map<Type, T> userMap = new HashMap();
    private final List<Pair<Class<?>, T>> systemTypeHierarchyList = new ArrayList();
    private final List<Pair<Class<?>, T>> userTypeHierarchyList = new ArrayList();
    private boolean modifiable = true;

    public synchronized void registerForTypeHierarchy(Class<?> typeOfT, T value, boolean isSystem) {
        Pair<Class<?>, T> pair = new Pair<>(typeOfT, value);
        registerForTypeHierarchy(pair, isSystem);
    }

    public synchronized void registerForTypeHierarchy(Pair<Class<?>, T> pair, boolean isSystem) {
        if (!this.modifiable) {
            throw new IllegalStateException("Attempted to modify an unmodifiable map.");
        }
        List<Pair<Class<?>, T>> typeHierarchyList = isSystem ? this.systemTypeHierarchyList : this.userTypeHierarchyList;
        int index = getIndexOfSpecificHandlerForTypeHierarchy(pair.first, typeHierarchyList);
        if (index >= 0) {
            logger.log(Level.WARNING, "Overriding the existing type handler for {0}", pair.first);
            typeHierarchyList.remove(index);
        }
        int index2 = getIndexOfAnOverriddenHandler(pair.first, typeHierarchyList);
        if (index2 >= 0) {
            throw new IllegalArgumentException("The specified type handler for type " + pair.first + " hides the previously registered type hierarchy handler for " + typeHierarchyList.get(index2).first + ". Gson does not allow this.");
        }
        typeHierarchyList.add(0, pair);
    }

    private static <T> int getIndexOfAnOverriddenHandler(Class<?> type, List<Pair<Class<?>, T>> typeHierarchyList) {
        for (int i = typeHierarchyList.size() - 1; i >= 0; i--) {
            Pair<Class<?>, T> entry = typeHierarchyList.get(i);
            if (type.isAssignableFrom(entry.first)) {
                return i;
            }
        }
        return -1;
    }

    public synchronized void register(Type typeOfT, T value, boolean isSystem) {
        if (!this.modifiable) {
            throw new IllegalStateException("Attempted to modify an unmodifiable map.");
        }
        if (hasSpecificHandlerFor(typeOfT)) {
            logger.log(Level.WARNING, "Overriding the existing type handler for {0}", typeOfT);
        }
        Map<Type, T> map = isSystem ? this.systemMap : this.userMap;
        map.put(typeOfT, value);
    }

    public synchronized void registerIfAbsent(ParameterizedTypeHandlerMap<T> other) {
        if (!this.modifiable) {
            throw new IllegalStateException("Attempted to modify an unmodifiable map.");
        }
        for (Map.Entry<Type, T> entry : other.userMap.entrySet()) {
            if (!this.userMap.containsKey(entry.getKey())) {
                register(entry.getKey(), entry.getValue(), false);
            }
        }
        for (Map.Entry<Type, T> entry2 : other.systemMap.entrySet()) {
            if (!this.systemMap.containsKey(entry2.getKey())) {
                register(entry2.getKey(), entry2.getValue(), true);
            }
        }
        for (int i = other.userTypeHierarchyList.size() - 1; i >= 0; i--) {
            Pair<Class<?>, T> entry3 = other.userTypeHierarchyList.get(i);
            int index = getIndexOfSpecificHandlerForTypeHierarchy(entry3.first, this.userTypeHierarchyList);
            if (index < 0) {
                registerForTypeHierarchy(entry3, false);
            }
        }
        for (int i2 = other.systemTypeHierarchyList.size() - 1; i2 >= 0; i2--) {
            Pair<Class<?>, T> entry4 = other.systemTypeHierarchyList.get(i2);
            int index2 = getIndexOfSpecificHandlerForTypeHierarchy(entry4.first, this.systemTypeHierarchyList);
            if (index2 < 0) {
                registerForTypeHierarchy(entry4, true);
            }
        }
    }

    public synchronized ParameterizedTypeHandlerMap<T> makeUnmodifiable() {
        this.modifiable = false;
        return this;
    }

    public synchronized T getHandlerFor(Type type, boolean systemOnly) {
        T handler;
        T handler2;
        if (!systemOnly) {
            T handler3 = this.userMap.get(type);
            if (handler3 != null) {
                handler = handler3;
            }
        }
        T handler4 = this.systemMap.get(type);
        if (handler4 != null) {
            handler = handler4;
        } else {
            Class<?> rawClass = C$Gson$Types.getRawType(type);
            handler = (rawClass == type || (handler2 = getHandlerFor(rawClass, systemOnly)) == null) ? getHandlerForTypeHierarchy(rawClass, systemOnly) : handler2;
        }
        return handler;
    }

    private T getHandlerForTypeHierarchy(Class<?> type, boolean systemOnly) {
        if (!systemOnly) {
            for (Pair<Class<?>, T> entry : this.userTypeHierarchyList) {
                if (entry.first.isAssignableFrom(type)) {
                    return entry.second;
                }
            }
        }
        for (Pair<Class<?>, T> entry2 : this.systemTypeHierarchyList) {
            if (entry2.first.isAssignableFrom(type)) {
                return entry2.second;
            }
        }
        return null;
    }

    public synchronized boolean hasSpecificHandlerFor(Type type) {
        return this.userMap.containsKey(type) || this.systemMap.containsKey(type);
    }

    private static <T> int getIndexOfSpecificHandlerForTypeHierarchy(Class<?> type, List<Pair<Class<?>, T>> typeHierarchyList) {
        for (int i = typeHierarchyList.size() - 1; i >= 0; i--) {
            if (type.equals(typeHierarchyList.get(i).first)) {
                return i;
            }
        }
        return -1;
    }

    public synchronized ParameterizedTypeHandlerMap<T> copyOf() {
        ParameterizedTypeHandlerMap<T> copy;
        copy = new ParameterizedTypeHandlerMap<>();
        copy.systemMap.putAll(this.systemMap);
        copy.userMap.putAll(this.userMap);
        copy.systemTypeHierarchyList.addAll(this.systemTypeHierarchyList);
        copy.userTypeHierarchyList.addAll(this.userTypeHierarchyList);
        return copy;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("{userTypeHierarchyList:{");
        appendList(sb, this.userTypeHierarchyList);
        sb.append("},systemTypeHierarchyList:{");
        appendList(sb, this.systemTypeHierarchyList);
        sb.append("},userMap:{");
        appendMap(sb, this.userMap);
        sb.append("},systemMap:{");
        appendMap(sb, this.systemMap);
        sb.append("}");
        return sb.toString();
    }

    private void appendList(StringBuilder sb, List<Pair<Class<?>, T>> list) {
        boolean first = true;
        for (Pair<Class<?>, T> entry : list) {
            if (first) {
                first = false;
            } else {
                sb.append(',');
            }
            sb.append(typeToString(entry.first)).append(':');
            sb.append(entry.second);
        }
    }

    private void appendMap(StringBuilder sb, Map<Type, T> map) {
        boolean first = true;
        for (Map.Entry<Type, T> entry : map.entrySet()) {
            if (first) {
                first = false;
            } else {
                sb.append(',');
            }
            sb.append(typeToString(entry.getKey())).append(':');
            sb.append(entry.getValue());
        }
    }

    private String typeToString(Type type) {
        return C$Gson$Types.getRawType(type).getSimpleName();
    }
}
