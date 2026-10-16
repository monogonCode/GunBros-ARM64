package com.urbanairship.push.proto;

import com.glu.platform.android.facebook.GluFBConnect;
import com.google.protobuf.ByteString;
import com.google.protobuf.CodedInputStream;
import com.google.protobuf.CodedOutputStream;
import com.google.protobuf.ExtensionRegistryLite;
import com.google.protobuf.GeneratedMessageLite;
import com.google.protobuf.Internal;
import com.google.protobuf.InvalidProtocolBufferException;
import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public final class Rpc {

    public static final class Request extends GeneratedMessageLite {
        public static final int BODY_FIELD_NUMBER = 2;
        public static final int METHOD_ID_FIELD_NUMBER = 1;
        public static final int REQUEST_ID_FIELD_NUMBER = 3;
        private static final Request defaultInstance = new Request(true);
        private ByteString body_;
        private boolean hasBody;
        private boolean hasMethodId;
        private boolean hasRequestId;
        private int memoizedSerializedSize;
        private Messages.AirshipMethod methodId_;
        private String requestId_;

        public static final class Builder extends GeneratedMessageLite.Builder<Request, Builder> {
            private Request result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public Request buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new Request();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Request build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Request buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                Request request = this.result;
                this.result = null;
                return request;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new Request();
                return this;
            }

            public Builder clearBody() {
                this.result.hasBody = false;
                this.result.body_ = Request.getDefaultInstance().getBody();
                return this;
            }

            public Builder clearMethodId() {
                this.result.hasMethodId = false;
                this.result.methodId_ = Messages.AirshipMethod.REGISTER;
                return this;
            }

            public Builder clearRequestId() {
                this.result.hasRequestId = false;
                this.result.requestId_ = Request.getDefaultInstance().getRequestId();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            public ByteString getBody() {
                return this.result.getBody();
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Request getDefaultInstanceForType() {
                return Request.getDefaultInstance();
            }

            public Messages.AirshipMethod getMethodId() {
                return this.result.getMethodId();
            }

            public String getRequestId() {
                return this.result.getRequestId();
            }

            public boolean hasBody() {
                return this.result.hasBody();
            }

            public boolean hasMethodId() {
                return this.result.hasMethodId();
            }

            public boolean hasRequestId() {
                return this.result.hasRequestId();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Request internalGetResult() {
                return this.result;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public boolean isInitialized() {
                return this.result.isInitialized();
            }

            @Override // com.google.protobuf.AbstractMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Builder mergeFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
                while (true) {
                    int tag = codedInputStream.readTag();
                    switch (tag) {
                        case 0:
                            break;
                        case 8:
                            Messages.AirshipMethod airshipMethodValueOf = Messages.AirshipMethod.valueOf(codedInputStream.readEnum());
                            if (airshipMethodValueOf != null) {
                                setMethodId(airshipMethodValueOf);
                            }
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setBody(codedInputStream.readBytes());
                            break;
                        case 26:
                            setRequestId(codedInputStream.readString());
                            break;
                        default:
                            if (!parseUnknownField(codedInputStream, extensionRegistryLite, tag)) {
                            }
                            break;
                    }
                }
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Builder mergeFrom(Request request) {
                if (request != Request.getDefaultInstance()) {
                    if (request.hasMethodId()) {
                        setMethodId(request.getMethodId());
                    }
                    if (request.hasBody()) {
                        setBody(request.getBody());
                    }
                    if (request.hasRequestId()) {
                        setRequestId(request.getRequestId());
                    }
                }
                return this;
            }

            public Builder setBody(ByteString byteString) {
                if (byteString == null) {
                    throw new NullPointerException();
                }
                this.result.hasBody = true;
                this.result.body_ = byteString;
                return this;
            }

            public Builder setMethodId(Messages.AirshipMethod airshipMethod) {
                if (airshipMethod == null) {
                    throw new NullPointerException();
                }
                this.result.hasMethodId = true;
                this.result.methodId_ = airshipMethod;
                return this;
            }

            public Builder setRequestId(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasRequestId = true;
                this.result.requestId_ = str;
                return this;
            }
        }

        static {
            Rpc.internalForceInit();
            defaultInstance.initFields();
        }

        private Request() {
            this.body_ = ByteString.EMPTY;
            this.requestId_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private Request(boolean z) {
            this.body_ = ByteString.EMPTY;
            this.requestId_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static Request getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
            this.methodId_ = Messages.AirshipMethod.REGISTER;
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(Request request) {
            return newBuilder().mergeFrom(request);
        }

        public static Request parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static Request parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static Request parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Request parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        public ByteString getBody() {
            return this.body_;
        }

        @Override // com.google.protobuf.MessageLite
        public Request getDefaultInstanceForType() {
            return defaultInstance;
        }

        public Messages.AirshipMethod getMethodId() {
            return this.methodId_;
        }

        public String getRequestId() {
            return this.requestId_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeEnumSize = this.memoizedSerializedSize;
            if (iComputeEnumSize == -1) {
                iComputeEnumSize = hasMethodId() ? 0 + CodedOutputStream.computeEnumSize(1, getMethodId().getNumber()) : 0;
                if (hasBody()) {
                    iComputeEnumSize += CodedOutputStream.computeBytesSize(2, getBody());
                }
                if (hasRequestId()) {
                    iComputeEnumSize += CodedOutputStream.computeStringSize(3, getRequestId());
                }
                this.memoizedSerializedSize = iComputeEnumSize;
            }
            return iComputeEnumSize;
        }

        public boolean hasBody() {
            return this.hasBody;
        }

        public boolean hasMethodId() {
            return this.hasMethodId;
        }

        public boolean hasRequestId() {
            return this.hasRequestId;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasMethodId && this.hasBody;
        }

        @Override // com.google.protobuf.MessageLite
        public Builder newBuilderForType() {
            return newBuilder();
        }

        @Override // com.google.protobuf.MessageLite
        public Builder toBuilder() {
            return newBuilder(this);
        }

        @Override // com.google.protobuf.MessageLite
        public void writeTo(CodedOutputStream codedOutputStream) throws IOException {
            getSerializedSize();
            if (hasMethodId()) {
                codedOutputStream.writeEnum(1, getMethodId().getNumber());
            }
            if (hasBody()) {
                codedOutputStream.writeBytes(2, getBody());
            }
            if (hasRequestId()) {
                codedOutputStream.writeString(3, getRequestId());
            }
        }
    }

    public static final class Response extends GeneratedMessageLite {
        public static final int BODY_FIELD_NUMBER = 2;
        public static final int REQUEST_ID_FIELD_NUMBER = 3;
        public static final int STATUS_FIELD_NUMBER = 1;
        private static final Response defaultInstance = new Response(true);
        private ByteString body_;
        private boolean hasBody;
        private boolean hasRequestId;
        private boolean hasStatus;
        private int memoizedSerializedSize;
        private String requestId_;
        private Status status_;

        public static final class Builder extends GeneratedMessageLite.Builder<Response, Builder> {
            private Response result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public Response buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new Response();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Response build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Response buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                Response response = this.result;
                this.result = null;
                return response;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new Response();
                return this;
            }

            public Builder clearBody() {
                this.result.hasBody = false;
                this.result.body_ = Response.getDefaultInstance().getBody();
                return this;
            }

            public Builder clearRequestId() {
                this.result.hasRequestId = false;
                this.result.requestId_ = Response.getDefaultInstance().getRequestId();
                return this;
            }

            public Builder clearStatus() {
                this.result.hasStatus = false;
                this.result.status_ = Status.OK;
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            public ByteString getBody() {
                return this.result.getBody();
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Response getDefaultInstanceForType() {
                return Response.getDefaultInstance();
            }

            public String getRequestId() {
                return this.result.getRequestId();
            }

            public Status getStatus() {
                return this.result.getStatus();
            }

            public boolean hasBody() {
                return this.result.hasBody();
            }

            public boolean hasRequestId() {
                return this.result.hasRequestId();
            }

            public boolean hasStatus() {
                return this.result.hasStatus();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Response internalGetResult() {
                return this.result;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public boolean isInitialized() {
                return this.result.isInitialized();
            }

            @Override // com.google.protobuf.AbstractMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Builder mergeFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
                while (true) {
                    int tag = codedInputStream.readTag();
                    switch (tag) {
                        case 0:
                            break;
                        case 8:
                            Status statusValueOf = Status.valueOf(codedInputStream.readEnum());
                            if (statusValueOf != null) {
                                setStatus(statusValueOf);
                            }
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setBody(codedInputStream.readBytes());
                            break;
                        case 26:
                            setRequestId(codedInputStream.readString());
                            break;
                        default:
                            if (!parseUnknownField(codedInputStream, extensionRegistryLite, tag)) {
                            }
                            break;
                    }
                }
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Builder mergeFrom(Response response) {
                if (response != Response.getDefaultInstance()) {
                    if (response.hasStatus()) {
                        setStatus(response.getStatus());
                    }
                    if (response.hasBody()) {
                        setBody(response.getBody());
                    }
                    if (response.hasRequestId()) {
                        setRequestId(response.getRequestId());
                    }
                }
                return this;
            }

            public Builder setBody(ByteString byteString) {
                if (byteString == null) {
                    throw new NullPointerException();
                }
                this.result.hasBody = true;
                this.result.body_ = byteString;
                return this;
            }

            public Builder setRequestId(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasRequestId = true;
                this.result.requestId_ = str;
                return this;
            }

            public Builder setStatus(Status status) {
                if (status == null) {
                    throw new NullPointerException();
                }
                this.result.hasStatus = true;
                this.result.status_ = status;
                return this;
            }
        }

        static {
            Rpc.internalForceInit();
            defaultInstance.initFields();
        }

        private Response() {
            this.body_ = ByteString.EMPTY;
            this.requestId_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private Response(boolean z) {
            this.body_ = ByteString.EMPTY;
            this.requestId_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static Response getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
            this.status_ = Status.OK;
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(Response response) {
            return newBuilder().mergeFrom(response);
        }

        public static Response parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static Response parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static Response parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Response parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        public ByteString getBody() {
            return this.body_;
        }

        @Override // com.google.protobuf.MessageLite
        public Response getDefaultInstanceForType() {
            return defaultInstance;
        }

        public String getRequestId() {
            return this.requestId_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeEnumSize = this.memoizedSerializedSize;
            if (iComputeEnumSize == -1) {
                iComputeEnumSize = hasStatus() ? 0 + CodedOutputStream.computeEnumSize(1, getStatus().getNumber()) : 0;
                if (hasBody()) {
                    iComputeEnumSize += CodedOutputStream.computeBytesSize(2, getBody());
                }
                if (hasRequestId()) {
                    iComputeEnumSize += CodedOutputStream.computeStringSize(3, getRequestId());
                }
                this.memoizedSerializedSize = iComputeEnumSize;
            }
            return iComputeEnumSize;
        }

        public Status getStatus() {
            return this.status_;
        }

        public boolean hasBody() {
            return this.hasBody;
        }

        public boolean hasRequestId() {
            return this.hasRequestId;
        }

        public boolean hasStatus() {
            return this.hasStatus;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasStatus;
        }

        @Override // com.google.protobuf.MessageLite
        public Builder newBuilderForType() {
            return newBuilder();
        }

        @Override // com.google.protobuf.MessageLite
        public Builder toBuilder() {
            return newBuilder(this);
        }

        @Override // com.google.protobuf.MessageLite
        public void writeTo(CodedOutputStream codedOutputStream) throws IOException {
            getSerializedSize();
            if (hasStatus()) {
                codedOutputStream.writeEnum(1, getStatus().getNumber());
            }
            if (hasBody()) {
                codedOutputStream.writeBytes(2, getBody());
            }
            if (hasRequestId()) {
                codedOutputStream.writeString(3, getRequestId());
            }
        }
    }

    public enum Status implements Internal.EnumLite {
        OK(0, 0),
        BAD_REQUEST(1, 1),
        METHOD_NOT_FOUND(2, 2),
        RPC_ERROR(3, 3),
        TIMEOUT(4, 4);

        private static Internal.EnumLiteMap<Status> internalValueMap = new Internal.EnumLiteMap<Status>() { // from class: com.urbanairship.push.proto.Rpc.Status.1
            @Override // com.google.protobuf.Internal.EnumLiteMap
            public Status findValueByNumber(int i) {
                return Status.valueOf(i);
            }
        };
        private final int index;
        private final int value;

        Status(int i, int i2) {
            this.index = i;
            this.value = i2;
        }

        public static Internal.EnumLiteMap<Status> internalGetValueMap() {
            return internalValueMap;
        }

        public static Status valueOf(int i) {
            switch (i) {
                case 0:
                    return OK;
                case 1:
                    return BAD_REQUEST;
                case 2:
                    return METHOD_NOT_FOUND;
                case 3:
                    return RPC_ERROR;
                case 4:
                    return TIMEOUT;
                default:
                    return null;
            }
        }

        @Override // com.google.protobuf.Internal.EnumLite
        public final int getNumber() {
            return this.value;
        }
    }

    private Rpc() {
    }

    public static void internalForceInit() {
    }

    public static void registerAllExtensions(ExtensionRegistryLite extensionRegistryLite) {
    }
}
