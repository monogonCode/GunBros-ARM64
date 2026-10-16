package com.openfeint.internal.resource;

/* JADX INFO: loaded from: classes.dex */
public class BlobUploadParameters extends Resource {
    public String AWSAccessKeyId;
    public String acl;
    public String action;
    public String key;
    public String policy;
    public String signature;

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(BlobUploadParameters.class, "blob_upload_parameters") { // from class: com.openfeint.internal.resource.BlobUploadParameters.1
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new BlobUploadParameters();
            }
        };
        resourceClass.mProperties.put("action", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.2
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).action;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).action = str;
            }
        });
        resourceClass.mProperties.put("key", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.3
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).key;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).key = str;
            }
        });
        resourceClass.mProperties.put("AWSAccessKeyId", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.4
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).AWSAccessKeyId;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).AWSAccessKeyId = str;
            }
        });
        resourceClass.mProperties.put("acl", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.5
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).acl;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).acl = str;
            }
        });
        resourceClass.mProperties.put("policy", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.6
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).policy;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).policy = str;
            }
        });
        resourceClass.mProperties.put("signature", new StringResourceProperty() { // from class: com.openfeint.internal.resource.BlobUploadParameters.7
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((BlobUploadParameters) resource).signature;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((BlobUploadParameters) resource).signature = str;
            }
        });
        return resourceClass;
    }
}
