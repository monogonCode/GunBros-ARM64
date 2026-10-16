package com.openfeint.internal.resource;

import com.openfeint.api.resource.Achievement;
import com.openfeint.api.resource.CurrentUser;
import com.openfeint.api.resource.Leaderboard;
import com.openfeint.api.resource.Score;
import com.openfeint.api.resource.ServerTimestamp;
import com.openfeint.api.resource.User;
import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonFactory;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonGenerator;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public abstract class Resource {
    String mID;
    private static HashMap<Class<? extends Resource>, ResourceClass> sSubclassMap = new HashMap<>();
    private static HashMap<String, ResourceClass> sNameMap = new HashMap<>();

    static {
        registerSubclass(getResourceClass());
        registerSubclass(ServerException.getResourceClass());
        registerSubclass(Device.getResourceClass());
        registerSubclass(ParentalControl.getResourceClass());
        registerSubclass(ServerTimestamp.getResourceClass());
        registerSubclass(BlobUploadParameters.getResourceClass());
        registerSubclass(Achievement.getResourceClass());
        registerSubclass(Leaderboard.getResourceClass());
        registerSubclass(Score.getResourceClass());
        registerSubclass(User.getResourceClass());
        registerSubclass(CurrentUser.getResourceClass());
    }

    private void generate(JsonGenerator jsonGenerator) throws IOException {
        HashMap<String, Integer> map;
        ResourceClass klass = getKlass(getClass());
        jsonGenerator.writeStartObject();
        jsonGenerator.writeFieldName(klass.mResourceName);
        jsonGenerator.writeStartObject();
        for (Map.Entry<String, ResourceProperty> entry : klass.mProperties.entrySet()) {
            ResourceProperty value = entry.getValue();
            if (value instanceof PrimitiveResourceProperty) {
                ((PrimitiveResourceProperty) value).generate(this, jsonGenerator, entry.getKey());
            } else if (value instanceof ArrayResourceProperty) {
                ArrayResourceProperty arrayResourceProperty = (ArrayResourceProperty) value;
                List<? extends Resource> list = arrayResourceProperty.get(this);
                if (list != null) {
                    jsonGenerator.writeFieldName(entry.getKey());
                    ResourceClass klass2 = getKlass(arrayResourceProperty.elementType());
                    jsonGenerator.writeStartObject();
                    jsonGenerator.writeFieldName(klass2.mResourceName + "s");
                    jsonGenerator.writeStartArray();
                    Iterator<? extends Resource> it = list.iterator();
                    while (it.hasNext()) {
                        it.next().generate(jsonGenerator);
                    }
                    jsonGenerator.writeEndArray();
                    jsonGenerator.writeEndObject();
                }
            } else if (value instanceof NestedResourceProperty) {
                Resource resource = ((NestedResourceProperty) value).get(this);
                if (resource != null) {
                    jsonGenerator.writeFieldName(entry.getKey());
                    resource.generate(jsonGenerator);
                }
            } else if ((value instanceof HashIntResourceProperty) && (map = ((HashIntResourceProperty) value).get$44556ed()) != null && map.size() > 0) {
                jsonGenerator.writeFieldName(entry.getKey());
                jsonGenerator.writeStartObject();
                for (Map.Entry<String, Integer> entry2 : map.entrySet()) {
                    jsonGenerator.writeFieldName(entry2.getKey());
                    jsonGenerator.writeNumber(entry2.getValue().intValue());
                }
                jsonGenerator.writeEndObject();
            }
        }
        jsonGenerator.writeEndObject();
        jsonGenerator.writeEndObject();
    }

    public static ResourceClass getKlass(Class<?> cls) {
        return sSubclassMap.get(cls);
    }

    public static ResourceClass getKlass(String str) {
        return sNameMap.get(str);
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(Resource.class) { // from class: com.openfeint.internal.resource.Resource.1
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return null;
            }
        };
        resourceClass.mProperties.put("id", new StringResourceProperty() { // from class: com.openfeint.internal.resource.Resource.2
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return resource.mID;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                resource.mID = str;
            }
        });
        return resourceClass;
    }

    private static void registerSubclass(ResourceClass resourceClass) {
        sSubclassMap.put(resourceClass.mObjectClass, resourceClass);
        if (resourceClass.mResourceName != null) {
            sNameMap.put(resourceClass.mResourceName, resourceClass);
        }
    }

    private final void unguardedShallowCopy(Resource resource) {
        Iterator<Map.Entry<String, ResourceProperty>> it = getKlass(resource.getClass()).mProperties.entrySet().iterator();
        while (it.hasNext()) {
            ResourceProperty value = it.next().getValue();
            if (value instanceof PrimitiveResourceProperty) {
                ((PrimitiveResourceProperty) value).copy(this, resource);
            } else if (value instanceof ArrayResourceProperty) {
                ((ArrayResourceProperty) value).set(this, ((ArrayResourceProperty) value).get(resource));
            } else if (value instanceof NestedResourceProperty) {
                ((NestedResourceProperty) value).set(this, ((NestedResourceProperty) value).get(resource));
            }
        }
    }

    public final String generate() {
        StringWriter stringWriter = new StringWriter();
        try {
            JsonGenerator jsonGeneratorCreateJsonGenerator = new JsonFactory((byte) 0).createJsonGenerator(stringWriter);
            generate(jsonGeneratorCreateJsonGenerator);
            jsonGeneratorCreateJsonGenerator.close();
            return stringWriter.toString();
        } catch (IOException e) {
            OFLog.e("Resource", e.getMessage());
            return null;
        }
    }

    public final String resourceID() {
        return this.mID;
    }

    public final void setResourceID(String str) {
        this.mID = str;
    }

    public final void shallowCopy(Resource resource) {
        if (resource.getClass() != getClass()) {
            throw new UnsupportedOperationException("You can only shallowCopy the same type of resource");
        }
        unguardedShallowCopy(resource);
    }

    public final void shallowCopyAncestorType(Resource resource) {
        Class<?> superclass = getClass();
        Class<?> cls = resource.getClass();
        if (cls != Resource.class) {
            while (superclass != cls && superclass != Resource.class) {
                superclass = superclass.getSuperclass();
            }
            if (superclass == Resource.class) {
                throw new UnsupportedOperationException(cls.getName() + " is not a superclass of " + getClass().getName());
            }
        }
        unguardedShallowCopy(resource);
    }
}
