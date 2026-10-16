package com.openfeint.internal.resource;

/* JADX INFO: loaded from: classes.dex */
public abstract class NestedResourceProperty extends ResourceProperty {
    private Class<? extends Resource> mType;

    public NestedResourceProperty(Class<? extends Resource> cls) {
        this.mType = cls;
    }

    public abstract Resource get(Resource resource);

    public final Class<? extends Resource> getType() {
        return this.mType;
    }

    public abstract void set(Resource resource, Resource resource2);
}
