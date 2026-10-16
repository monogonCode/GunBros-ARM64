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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class Messages {

    public enum AirshipMethod implements Internal.EnumLite {
        REGISTER(0, 0),
        DEVICE_CONNECT(1, 1),
        PUSH_NOTIFICATION(2, 2),
        ECHO(3, 3),
        HELLO(4, 4);

        private static Internal.EnumLiteMap<AirshipMethod> internalValueMap = new Internal.EnumLiteMap<AirshipMethod>() { // from class: com.urbanairship.push.proto.Messages.AirshipMethod.1
            @Override // com.google.protobuf.Internal.EnumLiteMap
            public AirshipMethod findValueByNumber(int i) {
                return AirshipMethod.valueOf(i);
            }
        };
        private final int index;
        private final int value;

        AirshipMethod(int i, int i2) {
            this.index = i;
            this.value = i2;
        }

        public static Internal.EnumLiteMap<AirshipMethod> internalGetValueMap() {
            return internalValueMap;
        }

        public static AirshipMethod valueOf(int i) {
            switch (i) {
                case 0:
                    return REGISTER;
                case 1:
                    return DEVICE_CONNECT;
                case 2:
                    return PUSH_NOTIFICATION;
                case 3:
                    return ECHO;
                case 4:
                    return HELLO;
                default:
                    return null;
            }
        }

        @Override // com.google.protobuf.Internal.EnumLite
        public final int getNumber() {
            return this.value;
        }
    }

    public static final class DeviceConnect extends GeneratedMessageLite {
        public static final int DEVICE_ID_FIELD_NUMBER = 1;
        private static final DeviceConnect defaultInstance = new DeviceConnect(true);
        private String deviceId_;
        private boolean hasDeviceId;
        private int memoizedSerializedSize;

        public static final class Builder extends GeneratedMessageLite.Builder<DeviceConnect, Builder> {
            private DeviceConnect result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public DeviceConnect buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new DeviceConnect();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public DeviceConnect build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public DeviceConnect buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                DeviceConnect deviceConnect = this.result;
                this.result = null;
                return deviceConnect;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new DeviceConnect();
                return this;
            }

            public Builder clearDeviceId() {
                this.result.hasDeviceId = false;
                this.result.deviceId_ = DeviceConnect.getDefaultInstance().getDeviceId();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public DeviceConnect getDefaultInstanceForType() {
                return DeviceConnect.getDefaultInstance();
            }

            public String getDeviceId() {
                return this.result.getDeviceId();
            }

            public boolean hasDeviceId() {
                return this.result.hasDeviceId();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public DeviceConnect internalGetResult() {
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
                        case 10:
                            setDeviceId(codedInputStream.readString());
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
            public Builder mergeFrom(DeviceConnect deviceConnect) {
                if (deviceConnect != DeviceConnect.getDefaultInstance() && deviceConnect.hasDeviceId()) {
                    setDeviceId(deviceConnect.getDeviceId());
                }
                return this;
            }

            public Builder setDeviceId(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasDeviceId = true;
                this.result.deviceId_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private DeviceConnect() {
            this.deviceId_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private DeviceConnect(boolean z) {
            this.deviceId_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static DeviceConnect getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(DeviceConnect deviceConnect) {
            return newBuilder().mergeFrom(deviceConnect);
        }

        public static DeviceConnect parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static DeviceConnect parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static DeviceConnect parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static DeviceConnect parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        @Override // com.google.protobuf.MessageLite
        public DeviceConnect getDefaultInstanceForType() {
            return defaultInstance;
        }

        public String getDeviceId() {
            return this.deviceId_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeStringSize = this.memoizedSerializedSize;
            if (iComputeStringSize == -1) {
                iComputeStringSize = hasDeviceId() ? 0 + CodedOutputStream.computeStringSize(1, getDeviceId()) : 0;
                this.memoizedSerializedSize = iComputeStringSize;
            }
            return iComputeStringSize;
        }

        public boolean hasDeviceId() {
            return this.hasDeviceId;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasDeviceId;
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
            if (hasDeviceId()) {
                codedOutputStream.writeString(1, getDeviceId());
            }
        }
    }

    public static final class Hello extends GeneratedMessageLite {
        public static final int MESSAGE_FIELD_NUMBER = 1;
        private static final Hello defaultInstance = new Hello(true);
        private boolean hasMessage;
        private int memoizedSerializedSize;
        private String message_;

        public static final class Builder extends GeneratedMessageLite.Builder<Hello, Builder> {
            private Hello result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public Hello buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new Hello();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Hello build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Hello buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                Hello hello = this.result;
                this.result = null;
                return hello;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new Hello();
                return this;
            }

            public Builder clearMessage() {
                this.result.hasMessage = false;
                this.result.message_ = Hello.getDefaultInstance().getMessage();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Hello getDefaultInstanceForType() {
                return Hello.getDefaultInstance();
            }

            public String getMessage() {
                return this.result.getMessage();
            }

            public boolean hasMessage() {
                return this.result.hasMessage();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Hello internalGetResult() {
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
                        case 10:
                            setMessage(codedInputStream.readString());
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
            public Builder mergeFrom(Hello hello) {
                if (hello != Hello.getDefaultInstance() && hello.hasMessage()) {
                    setMessage(hello.getMessage());
                }
                return this;
            }

            public Builder setMessage(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasMessage = true;
                this.result.message_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private Hello() {
            this.message_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private Hello(boolean z) {
            this.message_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static Hello getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(Hello hello) {
            return newBuilder().mergeFrom(hello);
        }

        public static Hello parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static Hello parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static Hello parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Hello parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        @Override // com.google.protobuf.MessageLite
        public Hello getDefaultInstanceForType() {
            return defaultInstance;
        }

        public String getMessage() {
            return this.message_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeStringSize = this.memoizedSerializedSize;
            if (iComputeStringSize == -1) {
                iComputeStringSize = hasMessage() ? 0 + CodedOutputStream.computeStringSize(1, getMessage()) : 0;
                this.memoizedSerializedSize = iComputeStringSize;
            }
            return iComputeStringSize;
        }

        public boolean hasMessage() {
            return this.hasMessage;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasMessage;
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
            if (hasMessage()) {
                codedOutputStream.writeString(1, getMessage());
            }
        }
    }

    public static final class KeyValue extends GeneratedMessageLite {
        public static final int KEY_FIELD_NUMBER = 1;
        public static final int VALUE_FIELD_NUMBER = 2;
        private static final KeyValue defaultInstance = new KeyValue(true);
        private boolean hasKey;
        private boolean hasValue;
        private String key_;
        private int memoizedSerializedSize;
        private String value_;

        public static final class Builder extends GeneratedMessageLite.Builder<KeyValue, Builder> {
            private KeyValue result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public KeyValue buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new KeyValue();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public KeyValue build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public KeyValue buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                KeyValue keyValue = this.result;
                this.result = null;
                return keyValue;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new KeyValue();
                return this;
            }

            public Builder clearKey() {
                this.result.hasKey = false;
                this.result.key_ = KeyValue.getDefaultInstance().getKey();
                return this;
            }

            public Builder clearValue() {
                this.result.hasValue = false;
                this.result.value_ = KeyValue.getDefaultInstance().getValue();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public KeyValue getDefaultInstanceForType() {
                return KeyValue.getDefaultInstance();
            }

            public String getKey() {
                return this.result.getKey();
            }

            public String getValue() {
                return this.result.getValue();
            }

            public boolean hasKey() {
                return this.result.hasKey();
            }

            public boolean hasValue() {
                return this.result.hasValue();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public KeyValue internalGetResult() {
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
                        case 10:
                            setKey(codedInputStream.readString());
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setValue(codedInputStream.readString());
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
            public Builder mergeFrom(KeyValue keyValue) {
                if (keyValue != KeyValue.getDefaultInstance()) {
                    if (keyValue.hasKey()) {
                        setKey(keyValue.getKey());
                    }
                    if (keyValue.hasValue()) {
                        setValue(keyValue.getValue());
                    }
                }
                return this;
            }

            public Builder setKey(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasKey = true;
                this.result.key_ = str;
                return this;
            }

            public Builder setValue(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasValue = true;
                this.result.value_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private KeyValue() {
            this.key_ = "";
            this.value_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private KeyValue(boolean z) {
            this.key_ = "";
            this.value_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static KeyValue getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(KeyValue keyValue) {
            return newBuilder().mergeFrom(keyValue);
        }

        public static KeyValue parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static KeyValue parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static KeyValue parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static KeyValue parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        @Override // com.google.protobuf.MessageLite
        public KeyValue getDefaultInstanceForType() {
            return defaultInstance;
        }

        public String getKey() {
            return this.key_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeStringSize = this.memoizedSerializedSize;
            if (iComputeStringSize == -1) {
                iComputeStringSize = hasKey() ? 0 + CodedOutputStream.computeStringSize(1, getKey()) : 0;
                if (hasValue()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(2, getValue());
                }
                this.memoizedSerializedSize = iComputeStringSize;
            }
            return iComputeStringSize;
        }

        public String getValue() {
            return this.value_;
        }

        public boolean hasKey() {
            return this.hasKey;
        }

        public boolean hasValue() {
            return this.hasValue;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasKey && this.hasValue;
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
            if (hasKey()) {
                codedOutputStream.writeString(1, getKey());
            }
            if (hasValue()) {
                codedOutputStream.writeString(2, getValue());
            }
        }
    }

    public enum OS implements Internal.EnumLite {
        ANDROID(0, 0);

        private static Internal.EnumLiteMap<OS> internalValueMap = new Internal.EnumLiteMap<OS>() { // from class: com.urbanairship.push.proto.Messages.OS.1
            @Override // com.google.protobuf.Internal.EnumLiteMap
            public OS findValueByNumber(int i) {
                return OS.valueOf(i);
            }
        };
        private final int index;
        private final int value;

        OS(int i, int i2) {
            this.index = i;
            this.value = i2;
        }

        public static Internal.EnumLiteMap<OS> internalGetValueMap() {
            return internalValueMap;
        }

        public static OS valueOf(int i) {
            switch (i) {
                case 0:
                    return ANDROID;
                default:
                    return null;
            }
        }

        @Override // com.google.protobuf.Internal.EnumLite
        public final int getNumber() {
            return this.value;
        }
    }

    public static final class PushNotification extends GeneratedMessageLite {
        public static final int MAP_FIELD_NUMBER = 5;
        public static final int MESSAGE_FIELD_NUMBER = 2;
        public static final int MESSAGE_ID_FIELD_NUMBER = 1;
        public static final int PACKAGE_NAME_FIELD_NUMBER = 3;
        public static final int PAYLOAD_FIELD_NUMBER = 4;
        private static final PushNotification defaultInstance = new PushNotification(true);
        private boolean hasMessage;
        private boolean hasMessageId;
        private boolean hasPackageName;
        private boolean hasPayload;
        private List<KeyValue> map_;
        private int memoizedSerializedSize;
        private String messageId_;
        private String message_;
        private String packageName_;
        private String payload_;

        public static final class Builder extends GeneratedMessageLite.Builder<PushNotification, Builder> {
            private PushNotification result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public PushNotification buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new PushNotification();
                return builder;
            }

            public Builder addAllMap(Iterable<? extends KeyValue> iterable) {
                if (this.result.map_.isEmpty()) {
                    this.result.map_ = new ArrayList();
                }
                GeneratedMessageLite.Builder.addAll(iterable, this.result.map_);
                return this;
            }

            public Builder addMap(KeyValue.Builder builder) {
                if (this.result.map_.isEmpty()) {
                    this.result.map_ = new ArrayList();
                }
                this.result.map_.add(builder.build());
                return this;
            }

            public Builder addMap(KeyValue keyValue) {
                if (keyValue == null) {
                    throw new NullPointerException();
                }
                if (this.result.map_.isEmpty()) {
                    this.result.map_ = new ArrayList();
                }
                this.result.map_.add(keyValue);
                return this;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public PushNotification build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public PushNotification buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                if (this.result.map_ != Collections.EMPTY_LIST) {
                    this.result.map_ = Collections.unmodifiableList(this.result.map_);
                }
                PushNotification pushNotification = this.result;
                this.result = null;
                return pushNotification;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new PushNotification();
                return this;
            }

            public Builder clearMap() {
                this.result.map_ = Collections.emptyList();
                return this;
            }

            public Builder clearMessage() {
                this.result.hasMessage = false;
                this.result.message_ = PushNotification.getDefaultInstance().getMessage();
                return this;
            }

            public Builder clearMessageId() {
                this.result.hasMessageId = false;
                this.result.messageId_ = PushNotification.getDefaultInstance().getMessageId();
                return this;
            }

            public Builder clearPackageName() {
                this.result.hasPackageName = false;
                this.result.packageName_ = PushNotification.getDefaultInstance().getPackageName();
                return this;
            }

            public Builder clearPayload() {
                this.result.hasPayload = false;
                this.result.payload_ = PushNotification.getDefaultInstance().getPayload();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public PushNotification getDefaultInstanceForType() {
                return PushNotification.getDefaultInstance();
            }

            public KeyValue getMap(int i) {
                return this.result.getMap(i);
            }

            public int getMapCount() {
                return this.result.getMapCount();
            }

            public List<KeyValue> getMapList() {
                return Collections.unmodifiableList(this.result.map_);
            }

            public String getMessage() {
                return this.result.getMessage();
            }

            public String getMessageId() {
                return this.result.getMessageId();
            }

            public String getPackageName() {
                return this.result.getPackageName();
            }

            public String getPayload() {
                return this.result.getPayload();
            }

            public boolean hasMessage() {
                return this.result.hasMessage();
            }

            public boolean hasMessageId() {
                return this.result.hasMessageId();
            }

            public boolean hasPackageName() {
                return this.result.hasPackageName();
            }

            public boolean hasPayload() {
                return this.result.hasPayload();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public PushNotification internalGetResult() {
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
                        case 10:
                            setMessageId(codedInputStream.readString());
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setMessage(codedInputStream.readString());
                            break;
                        case 26:
                            setPackageName(codedInputStream.readString());
                            break;
                        case 34:
                            setPayload(codedInputStream.readString());
                            break;
                        case 42:
                            KeyValue.Builder builderNewBuilder = KeyValue.newBuilder();
                            codedInputStream.readMessage(builderNewBuilder, extensionRegistryLite);
                            addMap(builderNewBuilder.buildPartial());
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
            public Builder mergeFrom(PushNotification pushNotification) {
                if (pushNotification != PushNotification.getDefaultInstance()) {
                    if (pushNotification.hasMessageId()) {
                        setMessageId(pushNotification.getMessageId());
                    }
                    if (pushNotification.hasMessage()) {
                        setMessage(pushNotification.getMessage());
                    }
                    if (pushNotification.hasPackageName()) {
                        setPackageName(pushNotification.getPackageName());
                    }
                    if (pushNotification.hasPayload()) {
                        setPayload(pushNotification.getPayload());
                    }
                    if (!pushNotification.map_.isEmpty()) {
                        if (this.result.map_.isEmpty()) {
                            this.result.map_ = new ArrayList();
                        }
                        this.result.map_.addAll(pushNotification.map_);
                    }
                }
                return this;
            }

            public Builder setMap(int i, KeyValue.Builder builder) {
                this.result.map_.set(i, builder.build());
                return this;
            }

            public Builder setMap(int i, KeyValue keyValue) {
                if (keyValue == null) {
                    throw new NullPointerException();
                }
                this.result.map_.set(i, keyValue);
                return this;
            }

            public Builder setMessage(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasMessage = true;
                this.result.message_ = str;
                return this;
            }

            public Builder setMessageId(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasMessageId = true;
                this.result.messageId_ = str;
                return this;
            }

            public Builder setPackageName(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasPackageName = true;
                this.result.packageName_ = str;
                return this;
            }

            public Builder setPayload(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasPayload = true;
                this.result.payload_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private PushNotification() {
            this.messageId_ = "";
            this.message_ = "";
            this.packageName_ = "";
            this.payload_ = "";
            this.map_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private PushNotification(boolean z) {
            this.messageId_ = "";
            this.message_ = "";
            this.packageName_ = "";
            this.payload_ = "";
            this.map_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
        }

        public static PushNotification getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(PushNotification pushNotification) {
            return newBuilder().mergeFrom(pushNotification);
        }

        public static PushNotification parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static PushNotification parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static PushNotification parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static PushNotification parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        @Override // com.google.protobuf.MessageLite
        public PushNotification getDefaultInstanceForType() {
            return defaultInstance;
        }

        public KeyValue getMap(int i) {
            return this.map_.get(i);
        }

        public int getMapCount() {
            return this.map_.size();
        }

        public List<KeyValue> getMapList() {
            return this.map_;
        }

        public String getMessage() {
            return this.message_;
        }

        public String getMessageId() {
            return this.messageId_;
        }

        public String getPackageName() {
            return this.packageName_;
        }

        public String getPayload() {
            return this.payload_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int i = this.memoizedSerializedSize;
            if (i == -1) {
                int iComputeStringSize = hasMessageId() ? 0 + CodedOutputStream.computeStringSize(1, getMessageId()) : 0;
                if (hasMessage()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(2, getMessage());
                }
                if (hasPackageName()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(3, getPackageName());
                }
                if (hasPayload()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(4, getPayload());
                }
                Iterator<KeyValue> it = getMapList().iterator();
                while (true) {
                    i = iComputeStringSize;
                    if (!it.hasNext()) {
                        break;
                    }
                    iComputeStringSize = CodedOutputStream.computeMessageSize(5, it.next()) + i;
                }
                this.memoizedSerializedSize = i;
            }
            return i;
        }

        public boolean hasMessage() {
            return this.hasMessage;
        }

        public boolean hasMessageId() {
            return this.hasMessageId;
        }

        public boolean hasPackageName() {
            return this.hasPackageName;
        }

        public boolean hasPayload() {
            return this.hasPayload;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            if (this.hasMessageId && this.hasMessage && this.hasPackageName) {
                Iterator<KeyValue> it = getMapList().iterator();
                while (it.hasNext()) {
                    if (!it.next().isInitialized()) {
                        return false;
                    }
                }
                return true;
            }
            return false;
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
            if (hasMessageId()) {
                codedOutputStream.writeString(1, getMessageId());
            }
            if (hasMessage()) {
                codedOutputStream.writeString(2, getMessage());
            }
            if (hasPackageName()) {
                codedOutputStream.writeString(3, getPackageName());
            }
            if (hasPayload()) {
                codedOutputStream.writeString(4, getPayload());
            }
            Iterator<KeyValue> it = getMapList().iterator();
            while (it.hasNext()) {
                codedOutputStream.writeMessage(5, it.next());
            }
        }
    }

    public static final class Register extends GeneratedMessageLite {
        public static final int APID_FIELD_NUMBER = 1;
        public static final int OS_FIELD_NUMBER = 2;
        public static final int OS_VERSION_FIELD_NUMBER = 3;
        public static final int RELIERS_FIELD_NUMBER = 6;
        public static final int SECRET_FIELD_NUMBER = 5;
        public static final int UA_VERSION_FIELD_NUMBER = 4;
        private static final Register defaultInstance = new Register(true);
        private String apid_;
        private boolean hasApid;
        private boolean hasOs;
        private boolean hasOsVersion;
        private boolean hasSecret;
        private boolean hasUaVersion;
        private int memoizedSerializedSize;
        private String osVersion_;
        private OS os_;
        private List<Relier> reliers_;
        private String secret_;
        private String uaVersion_;

        public static final class Builder extends GeneratedMessageLite.Builder<Register, Builder> {
            private Register result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public Register buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new Register();
                return builder;
            }

            public Builder addAllReliers(Iterable<? extends Relier> iterable) {
                if (this.result.reliers_.isEmpty()) {
                    this.result.reliers_ = new ArrayList();
                }
                GeneratedMessageLite.Builder.addAll(iterable, this.result.reliers_);
                return this;
            }

            public Builder addReliers(Relier.Builder builder) {
                if (this.result.reliers_.isEmpty()) {
                    this.result.reliers_ = new ArrayList();
                }
                this.result.reliers_.add(builder.build());
                return this;
            }

            public Builder addReliers(Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                if (this.result.reliers_.isEmpty()) {
                    this.result.reliers_ = new ArrayList();
                }
                this.result.reliers_.add(relier);
                return this;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Register build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Register buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                if (this.result.reliers_ != Collections.EMPTY_LIST) {
                    this.result.reliers_ = Collections.unmodifiableList(this.result.reliers_);
                }
                Register register = this.result;
                this.result = null;
                return register;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new Register();
                return this;
            }

            public Builder clearApid() {
                this.result.hasApid = false;
                this.result.apid_ = Register.getDefaultInstance().getApid();
                return this;
            }

            public Builder clearOs() {
                this.result.hasOs = false;
                this.result.os_ = OS.ANDROID;
                return this;
            }

            public Builder clearOsVersion() {
                this.result.hasOsVersion = false;
                this.result.osVersion_ = Register.getDefaultInstance().getOsVersion();
                return this;
            }

            public Builder clearReliers() {
                this.result.reliers_ = Collections.emptyList();
                return this;
            }

            public Builder clearSecret() {
                this.result.hasSecret = false;
                this.result.secret_ = Register.getDefaultInstance().getSecret();
                return this;
            }

            public Builder clearUaVersion() {
                this.result.hasUaVersion = false;
                this.result.uaVersion_ = Register.getDefaultInstance().getUaVersion();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            public String getApid() {
                return this.result.getApid();
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Register getDefaultInstanceForType() {
                return Register.getDefaultInstance();
            }

            public OS getOs() {
                return this.result.getOs();
            }

            public String getOsVersion() {
                return this.result.getOsVersion();
            }

            public Relier getReliers(int i) {
                return this.result.getReliers(i);
            }

            public int getReliersCount() {
                return this.result.getReliersCount();
            }

            public List<Relier> getReliersList() {
                return Collections.unmodifiableList(this.result.reliers_);
            }

            public String getSecret() {
                return this.result.getSecret();
            }

            public String getUaVersion() {
                return this.result.getUaVersion();
            }

            public boolean hasApid() {
                return this.result.hasApid();
            }

            public boolean hasOs() {
                return this.result.hasOs();
            }

            public boolean hasOsVersion() {
                return this.result.hasOsVersion();
            }

            public boolean hasSecret() {
                return this.result.hasSecret();
            }

            public boolean hasUaVersion() {
                return this.result.hasUaVersion();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Register internalGetResult() {
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
                        case 10:
                            setApid(codedInputStream.readString());
                            break;
                        case 16:
                            OS osValueOf = OS.valueOf(codedInputStream.readEnum());
                            if (osValueOf != null) {
                                setOs(osValueOf);
                            }
                            break;
                        case 26:
                            setOsVersion(codedInputStream.readString());
                            break;
                        case 34:
                            setUaVersion(codedInputStream.readString());
                            break;
                        case 42:
                            setSecret(codedInputStream.readString());
                            break;
                        case 50:
                            Relier.Builder builderNewBuilder = Relier.newBuilder();
                            codedInputStream.readMessage(builderNewBuilder, extensionRegistryLite);
                            addReliers(builderNewBuilder.buildPartial());
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
            public Builder mergeFrom(Register register) {
                if (register != Register.getDefaultInstance()) {
                    if (register.hasApid()) {
                        setApid(register.getApid());
                    }
                    if (register.hasOs()) {
                        setOs(register.getOs());
                    }
                    if (register.hasOsVersion()) {
                        setOsVersion(register.getOsVersion());
                    }
                    if (register.hasUaVersion()) {
                        setUaVersion(register.getUaVersion());
                    }
                    if (register.hasSecret()) {
                        setSecret(register.getSecret());
                    }
                    if (!register.reliers_.isEmpty()) {
                        if (this.result.reliers_.isEmpty()) {
                            this.result.reliers_ = new ArrayList();
                        }
                        this.result.reliers_.addAll(register.reliers_);
                    }
                }
                return this;
            }

            public Builder setApid(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasApid = true;
                this.result.apid_ = str;
                return this;
            }

            public Builder setOs(OS os) {
                if (os == null) {
                    throw new NullPointerException();
                }
                this.result.hasOs = true;
                this.result.os_ = os;
                return this;
            }

            public Builder setOsVersion(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasOsVersion = true;
                this.result.osVersion_ = str;
                return this;
            }

            public Builder setReliers(int i, Relier.Builder builder) {
                this.result.reliers_.set(i, builder.build());
                return this;
            }

            public Builder setReliers(int i, Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                this.result.reliers_.set(i, relier);
                return this;
            }

            public Builder setSecret(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasSecret = true;
                this.result.secret_ = str;
                return this;
            }

            public Builder setUaVersion(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasUaVersion = true;
                this.result.uaVersion_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private Register() {
            this.apid_ = "";
            this.osVersion_ = "";
            this.uaVersion_ = "";
            this.secret_ = "";
            this.reliers_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private Register(boolean z) {
            this.apid_ = "";
            this.osVersion_ = "";
            this.uaVersion_ = "";
            this.secret_ = "";
            this.reliers_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
        }

        public static Register getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
            this.os_ = OS.ANDROID;
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(Register register) {
            return newBuilder().mergeFrom(register);
        }

        public static Register parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static Register parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static Register parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Register parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        public String getApid() {
            return this.apid_;
        }

        @Override // com.google.protobuf.MessageLite
        public Register getDefaultInstanceForType() {
            return defaultInstance;
        }

        public OS getOs() {
            return this.os_;
        }

        public String getOsVersion() {
            return this.osVersion_;
        }

        public Relier getReliers(int i) {
            return this.reliers_.get(i);
        }

        public int getReliersCount() {
            return this.reliers_.size();
        }

        public List<Relier> getReliersList() {
            return this.reliers_;
        }

        public String getSecret() {
            return this.secret_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int i = this.memoizedSerializedSize;
            if (i == -1) {
                int iComputeStringSize = hasApid() ? 0 + CodedOutputStream.computeStringSize(1, getApid()) : 0;
                if (hasOs()) {
                    iComputeStringSize += CodedOutputStream.computeEnumSize(2, getOs().getNumber());
                }
                if (hasOsVersion()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(3, getOsVersion());
                }
                if (hasUaVersion()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(4, getUaVersion());
                }
                if (hasSecret()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(5, getSecret());
                }
                Iterator<Relier> it = getReliersList().iterator();
                while (true) {
                    i = iComputeStringSize;
                    if (!it.hasNext()) {
                        break;
                    }
                    iComputeStringSize = CodedOutputStream.computeMessageSize(6, it.next()) + i;
                }
                this.memoizedSerializedSize = i;
            }
            return i;
        }

        public String getUaVersion() {
            return this.uaVersion_;
        }

        public boolean hasApid() {
            return this.hasApid;
        }

        public boolean hasOs() {
            return this.hasOs;
        }

        public boolean hasOsVersion() {
            return this.hasOsVersion;
        }

        public boolean hasSecret() {
            return this.hasSecret;
        }

        public boolean hasUaVersion() {
            return this.hasUaVersion;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            if (this.hasApid && this.hasOs && this.hasOsVersion && this.hasUaVersion && this.hasSecret) {
                Iterator<Relier> it = getReliersList().iterator();
                while (it.hasNext()) {
                    if (!it.next().isInitialized()) {
                        return false;
                    }
                }
                return true;
            }
            return false;
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
            if (hasApid()) {
                codedOutputStream.writeString(1, getApid());
            }
            if (hasOs()) {
                codedOutputStream.writeEnum(2, getOs().getNumber());
            }
            if (hasOsVersion()) {
                codedOutputStream.writeString(3, getOsVersion());
            }
            if (hasUaVersion()) {
                codedOutputStream.writeString(4, getUaVersion());
            }
            if (hasSecret()) {
                codedOutputStream.writeString(5, getSecret());
            }
            Iterator<Relier> it = getReliersList().iterator();
            while (it.hasNext()) {
                codedOutputStream.writeMessage(6, it.next());
            }
        }
    }

    public static final class RegistrationEnvelope extends GeneratedMessageLite {
        public static final int APID_FIELD_NUMBER = 1;
        public static final int REGISTRATION_FIELD_NUMBER = 2;
        private static final RegistrationEnvelope defaultInstance = new RegistrationEnvelope(true);
        private String apid_;
        private boolean hasApid;
        private boolean hasRegistration;
        private int memoizedSerializedSize;
        private ByteString registration_;

        public static final class Builder extends GeneratedMessageLite.Builder<RegistrationEnvelope, Builder> {
            private RegistrationEnvelope result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public RegistrationEnvelope buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new RegistrationEnvelope();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public RegistrationEnvelope build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public RegistrationEnvelope buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                RegistrationEnvelope registrationEnvelope = this.result;
                this.result = null;
                return registrationEnvelope;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new RegistrationEnvelope();
                return this;
            }

            public Builder clearApid() {
                this.result.hasApid = false;
                this.result.apid_ = RegistrationEnvelope.getDefaultInstance().getApid();
                return this;
            }

            public Builder clearRegistration() {
                this.result.hasRegistration = false;
                this.result.registration_ = RegistrationEnvelope.getDefaultInstance().getRegistration();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            public String getApid() {
                return this.result.getApid();
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public RegistrationEnvelope getDefaultInstanceForType() {
                return RegistrationEnvelope.getDefaultInstance();
            }

            public ByteString getRegistration() {
                return this.result.getRegistration();
            }

            public boolean hasApid() {
                return this.result.hasApid();
            }

            public boolean hasRegistration() {
                return this.result.hasRegistration();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public RegistrationEnvelope internalGetResult() {
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
                        case 10:
                            setApid(codedInputStream.readString());
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setRegistration(codedInputStream.readBytes());
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
            public Builder mergeFrom(RegistrationEnvelope registrationEnvelope) {
                if (registrationEnvelope != RegistrationEnvelope.getDefaultInstance()) {
                    if (registrationEnvelope.hasApid()) {
                        setApid(registrationEnvelope.getApid());
                    }
                    if (registrationEnvelope.hasRegistration()) {
                        setRegistration(registrationEnvelope.getRegistration());
                    }
                }
                return this;
            }

            public Builder setApid(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasApid = true;
                this.result.apid_ = str;
                return this;
            }

            public Builder setRegistration(ByteString byteString) {
                if (byteString == null) {
                    throw new NullPointerException();
                }
                this.result.hasRegistration = true;
                this.result.registration_ = byteString;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private RegistrationEnvelope() {
            this.apid_ = "";
            this.registration_ = ByteString.EMPTY;
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private RegistrationEnvelope(boolean z) {
            this.apid_ = "";
            this.registration_ = ByteString.EMPTY;
            this.memoizedSerializedSize = -1;
        }

        public static RegistrationEnvelope getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(RegistrationEnvelope registrationEnvelope) {
            return newBuilder().mergeFrom(registrationEnvelope);
        }

        public static RegistrationEnvelope parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static RegistrationEnvelope parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static RegistrationEnvelope parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationEnvelope parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        public String getApid() {
            return this.apid_;
        }

        @Override // com.google.protobuf.MessageLite
        public RegistrationEnvelope getDefaultInstanceForType() {
            return defaultInstance;
        }

        public ByteString getRegistration() {
            return this.registration_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeStringSize = this.memoizedSerializedSize;
            if (iComputeStringSize == -1) {
                iComputeStringSize = hasApid() ? 0 + CodedOutputStream.computeStringSize(1, getApid()) : 0;
                if (hasRegistration()) {
                    iComputeStringSize += CodedOutputStream.computeBytesSize(2, getRegistration());
                }
                this.memoizedSerializedSize = iComputeStringSize;
            }
            return iComputeStringSize;
        }

        public boolean hasApid() {
            return this.hasApid;
        }

        public boolean hasRegistration() {
            return this.hasRegistration;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasApid && this.hasRegistration;
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
            if (hasApid()) {
                codedOutputStream.writeString(1, getApid());
            }
            if (hasRegistration()) {
                codedOutputStream.writeBytes(2, getRegistration());
            }
        }
    }

    public static final class RegistrationResponse extends GeneratedMessageLite {
        public static final int INVALID_RELIERS_FIELD_NUMBER = 2;
        public static final int VALID_RELIERS_FIELD_NUMBER = 1;
        private static final RegistrationResponse defaultInstance = new RegistrationResponse(true);
        private List<Relier> invalidReliers_;
        private int memoizedSerializedSize;
        private List<Relier> validReliers_;

        public static final class Builder extends GeneratedMessageLite.Builder<RegistrationResponse, Builder> {
            private RegistrationResponse result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public RegistrationResponse buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new RegistrationResponse();
                return builder;
            }

            public Builder addAllInvalidReliers(Iterable<? extends Relier> iterable) {
                if (this.result.invalidReliers_.isEmpty()) {
                    this.result.invalidReliers_ = new ArrayList();
                }
                GeneratedMessageLite.Builder.addAll(iterable, this.result.invalidReliers_);
                return this;
            }

            public Builder addAllValidReliers(Iterable<? extends Relier> iterable) {
                if (this.result.validReliers_.isEmpty()) {
                    this.result.validReliers_ = new ArrayList();
                }
                GeneratedMessageLite.Builder.addAll(iterable, this.result.validReliers_);
                return this;
            }

            public Builder addInvalidReliers(Relier.Builder builder) {
                if (this.result.invalidReliers_.isEmpty()) {
                    this.result.invalidReliers_ = new ArrayList();
                }
                this.result.invalidReliers_.add(builder.build());
                return this;
            }

            public Builder addInvalidReliers(Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                if (this.result.invalidReliers_.isEmpty()) {
                    this.result.invalidReliers_ = new ArrayList();
                }
                this.result.invalidReliers_.add(relier);
                return this;
            }

            public Builder addValidReliers(Relier.Builder builder) {
                if (this.result.validReliers_.isEmpty()) {
                    this.result.validReliers_ = new ArrayList();
                }
                this.result.validReliers_.add(builder.build());
                return this;
            }

            public Builder addValidReliers(Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                if (this.result.validReliers_.isEmpty()) {
                    this.result.validReliers_ = new ArrayList();
                }
                this.result.validReliers_.add(relier);
                return this;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public RegistrationResponse build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public RegistrationResponse buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                if (this.result.validReliers_ != Collections.EMPTY_LIST) {
                    this.result.validReliers_ = Collections.unmodifiableList(this.result.validReliers_);
                }
                if (this.result.invalidReliers_ != Collections.EMPTY_LIST) {
                    this.result.invalidReliers_ = Collections.unmodifiableList(this.result.invalidReliers_);
                }
                RegistrationResponse registrationResponse = this.result;
                this.result = null;
                return registrationResponse;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new RegistrationResponse();
                return this;
            }

            public Builder clearInvalidReliers() {
                this.result.invalidReliers_ = Collections.emptyList();
                return this;
            }

            public Builder clearValidReliers() {
                this.result.validReliers_ = Collections.emptyList();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public RegistrationResponse getDefaultInstanceForType() {
                return RegistrationResponse.getDefaultInstance();
            }

            public Relier getInvalidReliers(int i) {
                return this.result.getInvalidReliers(i);
            }

            public int getInvalidReliersCount() {
                return this.result.getInvalidReliersCount();
            }

            public List<Relier> getInvalidReliersList() {
                return Collections.unmodifiableList(this.result.invalidReliers_);
            }

            public Relier getValidReliers(int i) {
                return this.result.getValidReliers(i);
            }

            public int getValidReliersCount() {
                return this.result.getValidReliersCount();
            }

            public List<Relier> getValidReliersList() {
                return Collections.unmodifiableList(this.result.validReliers_);
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public RegistrationResponse internalGetResult() {
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
                        case 10:
                            Relier.Builder builderNewBuilder = Relier.newBuilder();
                            codedInputStream.readMessage(builderNewBuilder, extensionRegistryLite);
                            addValidReliers(builderNewBuilder.buildPartial());
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            Relier.Builder builderNewBuilder2 = Relier.newBuilder();
                            codedInputStream.readMessage(builderNewBuilder2, extensionRegistryLite);
                            addInvalidReliers(builderNewBuilder2.buildPartial());
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
            public Builder mergeFrom(RegistrationResponse registrationResponse) {
                if (registrationResponse != RegistrationResponse.getDefaultInstance()) {
                    if (!registrationResponse.validReliers_.isEmpty()) {
                        if (this.result.validReliers_.isEmpty()) {
                            this.result.validReliers_ = new ArrayList();
                        }
                        this.result.validReliers_.addAll(registrationResponse.validReliers_);
                    }
                    if (!registrationResponse.invalidReliers_.isEmpty()) {
                        if (this.result.invalidReliers_.isEmpty()) {
                            this.result.invalidReliers_ = new ArrayList();
                        }
                        this.result.invalidReliers_.addAll(registrationResponse.invalidReliers_);
                    }
                }
                return this;
            }

            public Builder setInvalidReliers(int i, Relier.Builder builder) {
                this.result.invalidReliers_.set(i, builder.build());
                return this;
            }

            public Builder setInvalidReliers(int i, Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                this.result.invalidReliers_.set(i, relier);
                return this;
            }

            public Builder setValidReliers(int i, Relier.Builder builder) {
                this.result.validReliers_.set(i, builder.build());
                return this;
            }

            public Builder setValidReliers(int i, Relier relier) {
                if (relier == null) {
                    throw new NullPointerException();
                }
                this.result.validReliers_.set(i, relier);
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private RegistrationResponse() {
            this.validReliers_ = Collections.emptyList();
            this.invalidReliers_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private RegistrationResponse(boolean z) {
            this.validReliers_ = Collections.emptyList();
            this.invalidReliers_ = Collections.emptyList();
            this.memoizedSerializedSize = -1;
        }

        public static RegistrationResponse getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(RegistrationResponse registrationResponse) {
            return newBuilder().mergeFrom(registrationResponse);
        }

        public static RegistrationResponse parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static RegistrationResponse parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static RegistrationResponse parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static RegistrationResponse parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        @Override // com.google.protobuf.MessageLite
        public RegistrationResponse getDefaultInstanceForType() {
            return defaultInstance;
        }

        public Relier getInvalidReliers(int i) {
            return this.invalidReliers_.get(i);
        }

        public int getInvalidReliersCount() {
            return this.invalidReliers_.size();
        }

        public List<Relier> getInvalidReliersList() {
            return this.invalidReliers_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeMessageSize = this.memoizedSerializedSize;
            if (iComputeMessageSize == -1) {
                int iComputeMessageSize2 = 0;
                Iterator<Relier> it = getValidReliersList().iterator();
                while (true) {
                    iComputeMessageSize = iComputeMessageSize2;
                    if (!it.hasNext()) {
                        break;
                    }
                    iComputeMessageSize2 = CodedOutputStream.computeMessageSize(1, it.next()) + iComputeMessageSize;
                }
                Iterator<Relier> it2 = getInvalidReliersList().iterator();
                while (it2.hasNext()) {
                    iComputeMessageSize += CodedOutputStream.computeMessageSize(2, it2.next());
                }
                this.memoizedSerializedSize = iComputeMessageSize;
            }
            return iComputeMessageSize;
        }

        public Relier getValidReliers(int i) {
            return this.validReliers_.get(i);
        }

        public int getValidReliersCount() {
            return this.validReliers_.size();
        }

        public List<Relier> getValidReliersList() {
            return this.validReliers_;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            Iterator<Relier> it = getValidReliersList().iterator();
            while (it.hasNext()) {
                if (!it.next().isInitialized()) {
                    return false;
                }
            }
            Iterator<Relier> it2 = getInvalidReliersList().iterator();
            while (it2.hasNext()) {
                if (!it2.next().isInitialized()) {
                    return false;
                }
            }
            return true;
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
            Iterator<Relier> it = getValidReliersList().iterator();
            while (it.hasNext()) {
                codedOutputStream.writeMessage(1, it.next());
            }
            Iterator<Relier> it2 = getInvalidReliersList().iterator();
            while (it2.hasNext()) {
                codedOutputStream.writeMessage(2, it2.next());
            }
        }
    }

    public static final class Relier extends GeneratedMessageLite {
        public static final int APP_KEY_FIELD_NUMBER = 2;
        public static final int PACKAGE_FIELD_NUMBER = 1;
        private static final Relier defaultInstance = new Relier(true);
        private String appKey_;
        private boolean hasAppKey;
        private boolean hasPackage;
        private int memoizedSerializedSize;
        private String package_;

        public static final class Builder extends GeneratedMessageLite.Builder<Relier, Builder> {
            private Relier result;

            private Builder() {
            }

            /* JADX INFO: Access modifiers changed from: private */
            public Relier buildParsed() throws InvalidProtocolBufferException {
                if (isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result).asInvalidProtocolBufferException();
            }

            /* JADX INFO: Access modifiers changed from: private */
            public static Builder create() {
                Builder builder = new Builder();
                builder.result = new Relier();
                return builder;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Relier build() {
                if (this.result == null || isInitialized()) {
                    return buildPartial();
                }
                throw newUninitializedMessageException(this.result);
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Relier buildPartial() {
                if (this.result == null) {
                    throw new IllegalStateException("build() has already been called on this Builder.");
                }
                Relier relier = this.result;
                this.result = null;
                return relier;
            }

            @Override // com.google.protobuf.MessageLite.Builder
            public Builder clear() {
                if (this.result == null) {
                    throw new IllegalStateException("Cannot call clear() after build().");
                }
                this.result = new Relier();
                return this;
            }

            public Builder clearAppKey() {
                this.result.hasAppKey = false;
                this.result.appKey_ = Relier.getDefaultInstance().getAppKey();
                return this;
            }

            public Builder clearPackage() {
                this.result.hasPackage = false;
                this.result.package_ = Relier.getDefaultInstance().getPackage();
                return this;
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
            /* JADX INFO: renamed from: clone */
            public Builder mo0clone() {
                return create().mergeFrom(this.result);
            }

            public String getAppKey() {
                return this.result.getAppKey();
            }

            @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.MessageLite.Builder
            public Relier getDefaultInstanceForType() {
                return Relier.getDefaultInstance();
            }

            public String getPackage() {
                return this.result.getPackage();
            }

            public boolean hasAppKey() {
                return this.result.hasAppKey();
            }

            public boolean hasPackage() {
                return this.result.hasPackage();
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // com.google.protobuf.GeneratedMessageLite.Builder
            public Relier internalGetResult() {
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
                        case 10:
                            setPackage(codedInputStream.readString());
                            break;
                        case GluFBConnect.FACEBOOK_EVENT_QUEUE_FRIEND_IMAGE_URL /* 18 */:
                            setAppKey(codedInputStream.readString());
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
            public Builder mergeFrom(Relier relier) {
                if (relier != Relier.getDefaultInstance()) {
                    if (relier.hasPackage()) {
                        setPackage(relier.getPackage());
                    }
                    if (relier.hasAppKey()) {
                        setAppKey(relier.getAppKey());
                    }
                }
                return this;
            }

            public Builder setAppKey(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasAppKey = true;
                this.result.appKey_ = str;
                return this;
            }

            public Builder setPackage(String str) {
                if (str == null) {
                    throw new NullPointerException();
                }
                this.result.hasPackage = true;
                this.result.package_ = str;
                return this;
            }
        }

        static {
            Messages.internalForceInit();
            defaultInstance.initFields();
        }

        private Relier() {
            this.package_ = "";
            this.appKey_ = "";
            this.memoizedSerializedSize = -1;
            initFields();
        }

        private Relier(boolean z) {
            this.package_ = "";
            this.appKey_ = "";
            this.memoizedSerializedSize = -1;
        }

        public static Relier getDefaultInstance() {
            return defaultInstance;
        }

        private void initFields() {
        }

        public static Builder newBuilder() {
            return Builder.create();
        }

        public static Builder newBuilder(Relier relier) {
            return newBuilder().mergeFrom(relier);
        }

        public static Relier parseDelimitedFrom(InputStream inputStream) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        public static Relier parseDelimitedFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            Builder builderNewBuilder = newBuilder();
            if (builderNewBuilder.mergeDelimitedFrom(inputStream, extensionRegistryLite)) {
                return builderNewBuilder.buildParsed();
            }
            return null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(ByteString byteString) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(ByteString byteString, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(byteString, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(CodedInputStream codedInputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(codedInputStream)).buildParsed();
        }

        public static Relier parseFrom(CodedInputStream codedInputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return newBuilder().mergeFrom(codedInputStream, extensionRegistryLite).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(InputStream inputStream) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(InputStream inputStream, ExtensionRegistryLite extensionRegistryLite) throws IOException {
            return ((Builder) newBuilder().mergeFrom(inputStream, extensionRegistryLite)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(byte[] bArr) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr)).buildParsed();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public static Relier parseFrom(byte[] bArr, ExtensionRegistryLite extensionRegistryLite) throws InvalidProtocolBufferException {
            return ((Builder) newBuilder().mergeFrom(bArr, extensionRegistryLite)).buildParsed();
        }

        public String getAppKey() {
            return this.appKey_;
        }

        @Override // com.google.protobuf.MessageLite
        public Relier getDefaultInstanceForType() {
            return defaultInstance;
        }

        public String getPackage() {
            return this.package_;
        }

        @Override // com.google.protobuf.MessageLite
        public int getSerializedSize() {
            int iComputeStringSize = this.memoizedSerializedSize;
            if (iComputeStringSize == -1) {
                iComputeStringSize = hasPackage() ? 0 + CodedOutputStream.computeStringSize(1, getPackage()) : 0;
                if (hasAppKey()) {
                    iComputeStringSize += CodedOutputStream.computeStringSize(2, getAppKey());
                }
                this.memoizedSerializedSize = iComputeStringSize;
            }
            return iComputeStringSize;
        }

        public boolean hasAppKey() {
            return this.hasAppKey;
        }

        public boolean hasPackage() {
            return this.hasPackage;
        }

        @Override // com.google.protobuf.MessageLite
        public final boolean isInitialized() {
            return this.hasPackage && this.hasAppKey;
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
            if (hasPackage()) {
                codedOutputStream.writeString(1, getPackage());
            }
            if (hasAppKey()) {
                codedOutputStream.writeString(2, getAppKey());
            }
        }
    }

    private Messages() {
    }

    public static void internalForceInit() {
    }

    public static void registerAllExtensions(ExtensionRegistryLite extensionRegistryLite) {
    }
}
