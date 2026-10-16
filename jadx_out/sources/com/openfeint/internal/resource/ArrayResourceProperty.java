package com.openfeint.internal.resource;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class ArrayResourceProperty extends ResourceProperty {
    private Class<? extends Resource> mElementType;

    public ArrayResourceProperty(Class<? extends Resource> cls) {
        this.mElementType = cls;
    }

    public final Class<? extends Resource> elementType() {
        return this.mElementType;
    }

    public abstract List<? extends Resource> get(Resource resource);

    public abstract void set(Resource resource, List<?> list);
}
