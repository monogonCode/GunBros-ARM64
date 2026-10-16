package com.google.gson;

import com.google.gson.internal.C$Gson$Preconditions;
import com.google.gson.internal.Pair;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;

/* JADX INFO: loaded from: classes.dex */
public final class FieldAttributes {
    private static final Cache<Pair<Class<?>, String>, Collection<Annotation>> ANNOTATION_CACHE = new LruCache(getMaxCacheSize());
    private static final String MAX_CACHE_PROPERTY_NAME = "com.google.gson.annotation_cache_size_hint";
    private Collection<Annotation> annotations;
    private final Class<?> declaredType;
    private final Class<?> declaringClazz;
    private final Field field;
    private Type genericType;
    private final boolean isSynthetic;
    private final int modifiers;
    private final String name;

    FieldAttributes(Class<?> declaringClazz, Field f) {
        this.declaringClazz = (Class) C$Gson$Preconditions.checkNotNull(declaringClazz);
        this.name = f.getName();
        this.declaredType = f.getType();
        this.isSynthetic = f.isSynthetic();
        this.modifiers = f.getModifiers();
        this.field = f;
    }

    private static int getMaxCacheSize() {
        try {
            String propertyValue = System.getProperty(MAX_CACHE_PROPERTY_NAME, String.valueOf(2000));
            return Integer.parseInt(propertyValue);
        } catch (NumberFormatException e) {
            return 2000;
        }
    }

    public Class<?> getDeclaringClass() {
        return this.declaringClazz;
    }

    public String getName() {
        return this.name;
    }

    public Type getDeclaredType() {
        if (this.genericType == null) {
            this.genericType = this.field.getGenericType();
        }
        return this.genericType;
    }

    public Class<?> getDeclaredClass() {
        return this.declaredType;
    }

    public <T extends Annotation> T getAnnotation(Class<T> cls) {
        return (T) getAnnotationFromArray(getAnnotations(), cls);
    }

    public Collection<Annotation> getAnnotations() {
        if (this.annotations == null) {
            Pair<Class<?>, String> key = new Pair<>(this.declaringClazz, this.name);
            Collection<Annotation> cachedValue = ANNOTATION_CACHE.getElement(key);
            if (cachedValue == null) {
                cachedValue = Collections.unmodifiableCollection(Arrays.asList(this.field.getAnnotations()));
                ANNOTATION_CACHE.addElement(key, cachedValue);
            }
            this.annotations = cachedValue;
        }
        return this.annotations;
    }

    public boolean hasModifier(int modifier) {
        return (this.modifiers & modifier) != 0;
    }

    Object get(Object instance) throws IllegalAccessException {
        return this.field.get(instance);
    }

    boolean isSynthetic() {
        return this.isSynthetic;
    }

    @Deprecated
    Field getFieldObject() {
        return this.field;
    }

    private static <T extends Annotation> T getAnnotationFromArray(Collection<Annotation> annotations, Class<T> annotation) {
        Iterator<Annotation> it = annotations.iterator();
        while (it.hasNext()) {
            T t = (T) it.next();
            if (t.annotationType() == annotation) {
                return t;
            }
        }
        return null;
    }
}
