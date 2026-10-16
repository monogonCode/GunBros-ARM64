package com.openfeint.internal.resource;

import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public abstract class ResourceClass {
    public Class<? extends Resource> mObjectClass;
    public HashMap<String, ResourceProperty> mProperties = new HashMap<>();
    public String mResourceName;

    public ResourceClass(Class<? extends Resource> cls, String str) {
        this.mObjectClass = cls;
        this.mResourceName = str;
        mixinParentProperties(cls);
    }

    private void mixinParentProperties(Class<?> cls) {
        if (cls != Resource.class) {
            Class<? super Object> superclass = cls.getSuperclass();
            mixinParentProperties(superclass);
            ResourceClass klass = Resource.getKlass(superclass);
            for (String str : klass.mProperties.keySet()) {
                this.mProperties.put(str, klass.mProperties.get(str));
            }
        }
    }

    public abstract Resource factory();
}
