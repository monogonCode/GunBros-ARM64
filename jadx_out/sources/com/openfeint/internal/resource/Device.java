package com.openfeint.internal.resource;

import com.openfeint.api.resource.User;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class Device extends Resource {
    public ParentalControl parental_control;
    public List<User> users;

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(Device.class, "device") { // from class: com.openfeint.internal.resource.Device.1
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new Device();
            }
        };
        resourceClass.mProperties.put("users", new ArrayResourceProperty(User.class) { // from class: com.openfeint.internal.resource.Device.2
            @Override // com.openfeint.internal.resource.ArrayResourceProperty
            public final List<? extends Resource> get(Resource resource) {
                return ((Device) resource).users;
            }

            /* JADX WARN: Multi-variable type inference failed */
            @Override // com.openfeint.internal.resource.ArrayResourceProperty
            public final void set(Resource resource, List<?> list) {
                ((Device) resource).users = list;
            }
        });
        resourceClass.mProperties.put("parental_control", new NestedResourceProperty(ParentalControl.class) { // from class: com.openfeint.internal.resource.Device.3
            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final Resource get(Resource resource) {
                return ((Device) resource).parental_control;
            }

            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final void set(Resource resource, Resource resource2) {
                ((Device) resource).parental_control = (ParentalControl) resource2;
            }
        });
        return resourceClass;
    }
}
