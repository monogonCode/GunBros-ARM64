package com.google.protobuf;

import java.io.IOException;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public abstract class GeneratedMessageLite extends AbstractMessageLite {
    protected GeneratedMessageLite() {
    }

    public static abstract class Builder<MessageType extends GeneratedMessageLite, BuilderType extends Builder> extends AbstractMessageLite.Builder<BuilderType> {
        @Override // com.google.protobuf.MessageLite.Builder
        public abstract MessageType getDefaultInstanceForType();

        protected abstract MessageType internalGetResult();

        public abstract BuilderType mergeFrom(MessageType messagetype);

        protected Builder() {
        }

        @Override // com.google.protobuf.AbstractMessageLite.Builder
        /* JADX INFO: renamed from: clone, reason: merged with bridge method [inline-methods] */
        public BuilderType mo0clone() {
            throw new UnsupportedOperationException("This is supposed to be overridden by subclasses.");
        }

        protected boolean parseUnknownField(CodedInputStream input, ExtensionRegistryLite extensionRegistry, int tag) throws IOException {
            return input.skipField(tag);
        }
    }

    public static abstract class ExtendableMessage<MessageType extends ExtendableMessage<MessageType>> extends GeneratedMessageLite {
        private final FieldSet<ExtensionDescriptor> extensions = FieldSet.newFieldSet();

        protected ExtendableMessage() {
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void verifyExtensionContainingType(GeneratedExtension<MessageType, ?> extension) {
            if (extension.getContainingTypeDefaultInstance() != getDefaultInstanceForType()) {
                throw new IllegalArgumentException("This extension is for a different message type.  Please make sure that you are not suppressing any generics type warnings.");
            }
        }

        public final boolean hasExtension(GeneratedExtension<MessageType, ?> extension) {
            verifyExtensionContainingType(extension);
            return this.extensions.hasField(((GeneratedExtension) extension).descriptor);
        }

        public final <Type> int getExtensionCount(GeneratedExtension<MessageType, List<Type>> extension) {
            verifyExtensionContainingType(extension);
            return this.extensions.getRepeatedFieldCount(((GeneratedExtension) extension).descriptor);
        }

        /* JADX WARN: Multi-variable type inference failed */
        public final <Type> Type getExtension(GeneratedExtension<MessageType, Type> generatedExtension) {
            verifyExtensionContainingType(generatedExtension);
            Type type = (Type) this.extensions.getField(((GeneratedExtension) generatedExtension).descriptor);
            if (type != null) {
                return type;
            }
            return (Type) ((GeneratedExtension) generatedExtension).defaultValue;
        }

        public final <Type> Type getExtension(GeneratedExtension<MessageType, List<Type>> generatedExtension, int i) {
            verifyExtensionContainingType(generatedExtension);
            return (Type) this.extensions.getRepeatedField(((GeneratedExtension) generatedExtension).descriptor, i);
        }

        protected boolean extensionsAreInitialized() {
            return this.extensions.isInitialized();
        }

        protected class ExtensionWriter {
            private final Iterator<Map.Entry<ExtensionDescriptor, Object>> iter;
            private final boolean messageSetWireFormat;
            private Map.Entry<ExtensionDescriptor, Object> next;

            private ExtensionWriter(boolean messageSetWireFormat) {
                this.iter = ExtendableMessage.this.extensions.iterator();
                if (this.iter.hasNext()) {
                    this.next = this.iter.next();
                }
                this.messageSetWireFormat = messageSetWireFormat;
            }

            public void writeUntil(int end, CodedOutputStream output) throws IOException {
                while (this.next != null && this.next.getKey().getNumber() < end) {
                    ExtensionDescriptor extension = this.next.getKey();
                    if (this.messageSetWireFormat && extension.getLiteJavaType() == WireFormat.JavaType.MESSAGE && !extension.isRepeated()) {
                        output.writeMessageSetExtension(extension.getNumber(), (MessageLite) this.next.getValue());
                    } else {
                        FieldSet.writeField(extension, this.next.getValue(), output);
                    }
                    if (this.iter.hasNext()) {
                        this.next = this.iter.next();
                    } else {
                        this.next = null;
                    }
                }
            }
        }

        protected ExtendableMessage<MessageType>.ExtensionWriter newExtensionWriter() {
            return new ExtensionWriter(false);
        }

        protected ExtendableMessage<MessageType>.ExtensionWriter newMessageSetExtensionWriter() {
            return new ExtensionWriter(true);
        }

        protected int extensionsSerializedSize() {
            return this.extensions.getSerializedSize();
        }

        protected int extensionsSerializedSizeAsMessageSet() {
            return this.extensions.getMessageSetSerializedSize();
        }
    }

    public static abstract class ExtendableBuilder<MessageType extends ExtendableMessage<MessageType>, BuilderType extends ExtendableBuilder<MessageType, BuilderType>> extends Builder<MessageType, BuilderType> {
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // com.google.protobuf.GeneratedMessageLite.Builder
        public abstract MessageType internalGetResult();

        protected ExtendableBuilder() {
        }

        @Override // com.google.protobuf.GeneratedMessageLite.Builder, com.google.protobuf.AbstractMessageLite.Builder
        /* JADX INFO: renamed from: clone */
        public BuilderType mo0clone() {
            throw new UnsupportedOperationException("This is supposed to be overridden by subclasses.");
        }

        public final boolean hasExtension(GeneratedExtension<MessageType, ?> extension) {
            return internalGetResult().hasExtension(extension);
        }

        public final <Type> int getExtensionCount(GeneratedExtension<MessageType, List<Type>> extension) {
            return internalGetResult().getExtensionCount(extension);
        }

        public final <Type> Type getExtension(GeneratedExtension<MessageType, Type> generatedExtension) {
            return (Type) internalGetResult().getExtension(generatedExtension);
        }

        public final <Type> Type getExtension(GeneratedExtension<MessageType, List<Type>> generatedExtension, int i) {
            return (Type) internalGetResult().getExtension(generatedExtension, i);
        }

        public final <Type> BuilderType setExtension(GeneratedExtension<MessageType, Type> extension, Type value) {
            ExtendableMessage<MessageType> message = internalGetResult();
            message.verifyExtensionContainingType(extension);
            ((ExtendableMessage) message).extensions.setField(((GeneratedExtension) extension).descriptor, value);
            return this;
        }

        public final <Type> BuilderType setExtension(GeneratedExtension<MessageType, List<Type>> extension, int index, Type value) {
            ExtendableMessage<MessageType> message = internalGetResult();
            message.verifyExtensionContainingType(extension);
            ((ExtendableMessage) message).extensions.setRepeatedField(((GeneratedExtension) extension).descriptor, index, value);
            return this;
        }

        public final <Type> BuilderType addExtension(GeneratedExtension<MessageType, List<Type>> extension, Type value) {
            ExtendableMessage<MessageType> message = internalGetResult();
            message.verifyExtensionContainingType(extension);
            ((ExtendableMessage) message).extensions.addRepeatedField(((GeneratedExtension) extension).descriptor, value);
            return this;
        }

        public final <Type> BuilderType clearExtension(GeneratedExtension<MessageType, ?> extension) {
            ExtendableMessage<MessageType> message = internalGetResult();
            message.verifyExtensionContainingType(extension);
            ((ExtendableMessage) message).extensions.clearField(((GeneratedExtension) extension).descriptor);
            return this;
        }

        @Override // com.google.protobuf.GeneratedMessageLite.Builder
        protected boolean parseUnknownField(CodedInputStream input, ExtensionRegistryLite extensionRegistry, int tag) throws IOException {
            Object objFindValueByNumber;
            MessageLite existingValue;
            FieldSet<ExtensionDescriptor> extensions = internalGetResult().extensions;
            int wireType = WireFormat.getTagWireType(tag);
            int fieldNumber = WireFormat.getTagFieldNumber(tag);
            GeneratedExtension<MessageType, ?> extension = extensionRegistry.findLiteExtensionByNumber(getDefaultInstanceForType(), fieldNumber);
            boolean unknown = false;
            boolean packed = false;
            if (extension == null) {
                unknown = true;
            } else if (wireType == FieldSet.getWireFormatForFieldType(((GeneratedExtension) extension).descriptor.getLiteType(), false)) {
                packed = false;
            } else if (((GeneratedExtension) extension).descriptor.isRepeated && ((GeneratedExtension) extension).descriptor.type.isPackable() && wireType == FieldSet.getWireFormatForFieldType(((GeneratedExtension) extension).descriptor.getLiteType(), true)) {
                packed = true;
            } else {
                unknown = true;
            }
            if (unknown) {
                return input.skipField(tag);
            }
            if (packed) {
                int length = input.readRawVarint32();
                int limit = input.pushLimit(length);
                if (((GeneratedExtension) extension).descriptor.getLiteType() == WireFormat.FieldType.ENUM) {
                    while (input.getBytesUntilLimit() > 0) {
                        int rawValue = input.readEnum();
                        Internal.EnumLite value = ((GeneratedExtension) extension).descriptor.getEnumType().findValueByNumber(rawValue);
                        if (value == null) {
                            return true;
                        }
                        extensions.addRepeatedField(((GeneratedExtension) extension).descriptor, value);
                    }
                } else {
                    while (input.getBytesUntilLimit() > 0) {
                        extensions.addRepeatedField(((GeneratedExtension) extension).descriptor, FieldSet.readPrimitiveField(input, ((GeneratedExtension) extension).descriptor.getLiteType()));
                    }
                }
                input.popLimit(limit);
            } else {
                switch (((GeneratedExtension) extension).descriptor.getLiteJavaType()) {
                    case MESSAGE:
                        MessageLite.Builder subBuilder = null;
                        if (!((GeneratedExtension) extension).descriptor.isRepeated() && (existingValue = (MessageLite) extensions.getField(((GeneratedExtension) extension).descriptor)) != null) {
                            subBuilder = existingValue.toBuilder();
                        }
                        if (subBuilder == null) {
                            subBuilder = ((GeneratedExtension) extension).messageDefaultInstance.newBuilderForType();
                        }
                        if (((GeneratedExtension) extension).descriptor.getLiteType() == WireFormat.FieldType.GROUP) {
                            input.readGroup(extension.getNumber(), subBuilder, extensionRegistry);
                        } else {
                            input.readMessage(subBuilder, extensionRegistry);
                        }
                        objFindValueByNumber = subBuilder.build();
                        break;
                    case ENUM:
                        int rawValue2 = input.readEnum();
                        objFindValueByNumber = ((GeneratedExtension) extension).descriptor.getEnumType().findValueByNumber(rawValue2);
                        if (objFindValueByNumber == null) {
                            return true;
                        }
                        break;
                    default:
                        objFindValueByNumber = FieldSet.readPrimitiveField(input, ((GeneratedExtension) extension).descriptor.getLiteType());
                        break;
                }
                if (((GeneratedExtension) extension).descriptor.isRepeated()) {
                    extensions.addRepeatedField(((GeneratedExtension) extension).descriptor, objFindValueByNumber);
                } else {
                    extensions.setField(((GeneratedExtension) extension).descriptor, objFindValueByNumber);
                }
            }
            return true;
        }

        protected final void mergeExtensionFields(MessageType other) {
            internalGetResult().extensions.mergeFrom(((ExtendableMessage) other).extensions);
        }
    }

    public static <ContainingType extends MessageLite, Type> GeneratedExtension<ContainingType, Type> newGeneratedExtension() {
        return new GeneratedExtension<>();
    }

    private static final class ExtensionDescriptor implements FieldSet.FieldDescriptorLite<ExtensionDescriptor> {
        private final Internal.EnumLiteMap<?> enumTypeMap;
        private final boolean isPacked;
        private final boolean isRepeated;
        private final int number;
        private final WireFormat.FieldType type;

        private ExtensionDescriptor(Internal.EnumLiteMap<?> enumTypeMap, int number, WireFormat.FieldType type, boolean isRepeated, boolean isPacked) {
            this.enumTypeMap = enumTypeMap;
            this.number = number;
            this.type = type;
            this.isRepeated = isRepeated;
            this.isPacked = isPacked;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public int getNumber() {
            return this.number;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public WireFormat.FieldType getLiteType() {
            return this.type;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public WireFormat.JavaType getLiteJavaType() {
            return this.type.getJavaType();
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public boolean isRepeated() {
            return this.isRepeated;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public boolean isPacked() {
            return this.isPacked;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public Internal.EnumLiteMap<?> getEnumType() {
            return this.enumTypeMap;
        }

        @Override // com.google.protobuf.FieldSet.FieldDescriptorLite
        public MessageLite.Builder internalMergeFrom(MessageLite.Builder to, MessageLite from) {
            return ((Builder) to).mergeFrom((GeneratedMessageLite) from);
        }

        @Override // java.lang.Comparable
        public int compareTo(ExtensionDescriptor other) {
            return this.number - other.number;
        }
    }

    public static final class GeneratedExtension<ContainingType extends MessageLite, Type> {
        private ContainingType containingTypeDefaultInstance;
        private Type defaultValue;
        private ExtensionDescriptor descriptor;
        private MessageLite messageDefaultInstance;

        private GeneratedExtension() {
        }

        private void internalInit(ContainingType containingTypeDefaultInstance, Type defaultValue, MessageLite messageDefaultInstance, ExtensionDescriptor descriptor) {
            this.containingTypeDefaultInstance = containingTypeDefaultInstance;
            this.defaultValue = defaultValue;
            this.messageDefaultInstance = messageDefaultInstance;
            this.descriptor = descriptor;
        }

        public void internalInitSingular(ContainingType containingTypeDefaultInstance, Type defaultValue, MessageLite messageDefaultInstance, Internal.EnumLiteMap<?> enumTypeMap, int number, WireFormat.FieldType type) {
            boolean z = false;
            internalInit(containingTypeDefaultInstance, defaultValue, messageDefaultInstance, new ExtensionDescriptor(enumTypeMap, number, type, z, z));
        }

        public void internalInitRepeated(ContainingType containingTypeDefaultInstance, MessageLite messageDefaultInstance, Internal.EnumLiteMap<?> enumTypeMap, int number, WireFormat.FieldType type, boolean isPacked) {
            internalInit(containingTypeDefaultInstance, Collections.emptyList(), messageDefaultInstance, new ExtensionDescriptor(enumTypeMap, number, type, true, isPacked));
        }

        public ContainingType getContainingTypeDefaultInstance() {
            return this.containingTypeDefaultInstance;
        }

        public int getNumber() {
            return this.descriptor.getNumber();
        }

        public MessageLite getMessageDefaultInstance() {
            return this.messageDefaultInstance;
        }
    }
}
