package com.openfeint.api.resource;

import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;

/* JADX INFO: loaded from: classes.dex */
public class CurrentUser extends User {
    public static ResourceClass getResourceClass() {
        return new ResourceClass(CurrentUser.class, "current_user") { // from class: com.openfeint.api.resource.CurrentUser.2
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new CurrentUser();
            }
        };
    }
}
