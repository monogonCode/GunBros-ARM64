package com.openfeint.internal.resource;

/* JADX INFO: loaded from: classes.dex */
public class ParentalControl extends Resource {
    public boolean enabled;

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(ParentalControl.class, "parental_control") { // from class: com.openfeint.internal.resource.ParentalControl.1
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new ParentalControl();
            }
        };
        resourceClass.mProperties.put("enabled", new BooleanResourceProperty() { // from class: com.openfeint.internal.resource.ParentalControl.2
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((ParentalControl) resource).enabled;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((ParentalControl) resource).enabled = z;
            }
        });
        return resourceClass;
    }
}
