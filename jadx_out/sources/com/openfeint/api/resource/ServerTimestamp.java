package com.openfeint.api.resource;

import com.openfeint.internal.resource.DateResourceProperty;
import com.openfeint.internal.resource.LongResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.tapjoy.TapjoyConstants;
import java.util.Date;

/* JADX INFO: loaded from: classes.dex */
public class ServerTimestamp extends Resource {
    public long secondsSinceEpoch;
    public Date timestamp;

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(ServerTimestamp.class, "server_timestamp") { // from class: com.openfeint.api.resource.ServerTimestamp.2
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new ServerTimestamp();
            }
        };
        resourceClass.mProperties.put(TapjoyConstants.TJC_TIMESTAMP, new DateResourceProperty() { // from class: com.openfeint.api.resource.ServerTimestamp.3
            @Override // com.openfeint.internal.resource.DateResourceProperty
            public final Date get(Resource resource) {
                return ((ServerTimestamp) resource).timestamp;
            }

            @Override // com.openfeint.internal.resource.DateResourceProperty
            public final void set(Resource resource, Date date) {
                ((ServerTimestamp) resource).timestamp = date;
            }
        });
        resourceClass.mProperties.put("seconds_since_epoch", new LongResourceProperty() { // from class: com.openfeint.api.resource.ServerTimestamp.4
            @Override // com.openfeint.internal.resource.LongResourceProperty
            public final long get(Resource resource) {
                return ((ServerTimestamp) resource).secondsSinceEpoch;
            }

            @Override // com.openfeint.internal.resource.LongResourceProperty
            public final void set(Resource resource, long j) {
                ((ServerTimestamp) resource).secondsSinceEpoch = j;
            }
        });
        return resourceClass;
    }
}
