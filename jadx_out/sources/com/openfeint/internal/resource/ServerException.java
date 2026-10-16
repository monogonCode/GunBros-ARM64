package com.openfeint.internal.resource;

/* JADX INFO: loaded from: classes.dex */
public class ServerException extends Resource {
    public String exceptionClass;
    public String message;
    public boolean needsDeveloperAttention;

    public ServerException() {
    }

    public ServerException(String str, String str2) {
        this.exceptionClass = str;
        this.message = str2;
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(ServerException.class, "exception") { // from class: com.openfeint.internal.resource.ServerException.1
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new ServerException();
            }
        };
        resourceClass.mProperties.put("class", new StringResourceProperty() { // from class: com.openfeint.internal.resource.ServerException.2
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((ServerException) resource).exceptionClass;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((ServerException) resource).exceptionClass = str;
            }
        });
        resourceClass.mProperties.put("message", new StringResourceProperty() { // from class: com.openfeint.internal.resource.ServerException.3
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((ServerException) resource).message;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((ServerException) resource).message = str;
            }
        });
        resourceClass.mProperties.put("needs_developer_attention", new BooleanResourceProperty() { // from class: com.openfeint.internal.resource.ServerException.4
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((ServerException) resource).needsDeveloperAttention;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((ServerException) resource).needsDeveloperAttention = z;
            }
        });
        return resourceClass;
    }
}
