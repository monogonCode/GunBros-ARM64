package com.openfeint.internal;

import com.openfeint.internal.logcat.OFLog;
import com.openfeint.internal.resource.ArrayResourceProperty;
import com.openfeint.internal.resource.HashIntResourceProperty;
import com.openfeint.internal.resource.NestedResourceProperty;
import com.openfeint.internal.resource.PrimitiveResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.openfeint.internal.resource.ResourceProperty;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParseException;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonParser;
import com.openfeint.internal.vendor.org.codehaus.jackson.JsonToken;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public final class JsonResourceParser {
    private JsonParser mParser;

    public JsonResourceParser(JsonParser jsonParser) {
        this.mParser = jsonParser;
    }

    private ArrayList<Resource> parseOpenedArray() throws IOException {
        ArrayList<Resource> arrayList = new ArrayList<>();
        while (this.mParser.nextToken() != JsonToken.END_ARRAY) {
            if (this.mParser.nextToken() != JsonToken.FIELD_NAME) {
                throw new JsonParseException("Couldn't find wrapper object.", this.mParser.getTokenLocation());
            }
            String text = this.mParser.getText();
            ResourceClass klass = Resource.getKlass(text);
            if (klass == null) {
                throw new JsonParseException("Don't know class '" + text + "'.", this.mParser.getTokenLocation());
            }
            Resource resource = parseResource(klass);
            if (this.mParser.nextToken() != JsonToken.END_OBJECT) {
                throw new JsonParseException("Expected only one k/v in wrapper object.", this.mParser.getTokenLocation());
            }
            arrayList.add(resource);
        }
        return arrayList;
    }

    private HashMap<String, Integer> parseOpenedHash() throws IOException {
        HashMap<String, Integer> map = new HashMap<>();
        while (this.mParser.nextToken() == JsonToken.FIELD_NAME) {
            String text = this.mParser.getText();
            this.mParser.nextToken();
            map.put(text, Integer.valueOf(this.mParser.getIntValue()));
        }
        return map;
    }

    private Resource parseOpenedResource(ResourceClass resourceClass) throws IOException {
        ArrayList<Resource> openedArray;
        Resource resourceFactory = resourceClass.factory();
        while (this.mParser.nextToken() == JsonToken.FIELD_NAME) {
            ResourceProperty resourceProperty = resourceClass.mProperties.get(this.mParser.getText());
            if (resourceProperty == null) {
                this.mParser.nextToken();
                this.mParser.skipChildren();
            } else if (resourceProperty instanceof PrimitiveResourceProperty) {
                this.mParser.nextToken();
                ((PrimitiveResourceProperty) resourceProperty).parse(resourceFactory, this.mParser);
            } else if (resourceProperty instanceof NestedResourceProperty) {
                NestedResourceProperty nestedResourceProperty = (NestedResourceProperty) resourceProperty;
                ResourceClass klass = Resource.getKlass(nestedResourceProperty.getType());
                if (klass != null) {
                    nestedResourceProperty.set(resourceFactory, parseResource(klass));
                } else {
                    OFLog.e("JsonResourceParser", "unknown " + nestedResourceProperty.getType());
                }
            } else if (resourceProperty instanceof ArrayResourceProperty) {
                ArrayResourceProperty arrayResourceProperty = (ArrayResourceProperty) resourceProperty;
                JsonToken jsonTokenNextToken = this.mParser.nextToken();
                if (jsonTokenNextToken == JsonToken.VALUE_NULL) {
                    openedArray = null;
                } else {
                    if (jsonTokenNextToken != JsonToken.START_ARRAY) {
                        throw new JsonParseException("Wanted START_ARRAY", this.mParser.getCurrentLocation());
                    }
                    openedArray = parseOpenedArray();
                }
                arrayResourceProperty.set(resourceFactory, openedArray);
            } else if (resourceProperty instanceof HashIntResourceProperty) {
                JsonToken jsonTokenNextToken2 = this.mParser.nextToken();
                if (jsonTokenNextToken2 == JsonToken.VALUE_NULL) {
                    continue;
                } else {
                    if (jsonTokenNextToken2 != JsonToken.START_OBJECT) {
                        throw new JsonParseException("Expected START_OBJECT", this.mParser.getCurrentLocation());
                    }
                    parseOpenedHash();
                }
            } else {
                OFLog.e("JsonResourceParser", "Totally don't know what to do about this property");
                this.mParser.skipChildren();
            }
        }
        if (this.mParser.getCurrentToken() != JsonToken.END_OBJECT) {
            throw new JsonParseException("Expected END_OBJECT of " + resourceClass.mResourceName, this.mParser.getCurrentLocation());
        }
        return resourceFactory;
    }

    private Resource parseResource(ResourceClass resourceClass) throws IOException {
        JsonToken jsonTokenNextToken = this.mParser.nextToken();
        if (jsonTokenNextToken == JsonToken.VALUE_NULL) {
            return null;
        }
        if (jsonTokenNextToken != JsonToken.START_OBJECT) {
            throw new JsonParseException("Expected START_OBJECT of " + resourceClass.mResourceName, this.mParser.getCurrentLocation());
        }
        return parseOpenedResource(resourceClass);
    }

    public final Object parse() throws IOException {
        Object openedResource;
        JsonToken jsonTokenNextToken = this.mParser.nextToken();
        if (jsonTokenNextToken == null) {
            return null;
        }
        if (jsonTokenNextToken != JsonToken.START_OBJECT) {
            throw new JsonParseException("Couldn't find toplevel wrapper object.", this.mParser.getTokenLocation());
        }
        if (this.mParser.nextToken() != JsonToken.FIELD_NAME) {
            throw new JsonParseException("Couldn't find toplevel wrapper object.", this.mParser.getTokenLocation());
        }
        String text = this.mParser.getText();
        JsonToken jsonTokenNextToken2 = this.mParser.nextToken();
        if (jsonTokenNextToken2 == JsonToken.START_ARRAY) {
            openedResource = parseOpenedArray();
        } else {
            if (jsonTokenNextToken2 != JsonToken.START_OBJECT) {
                throw new JsonParseException("Expected object or array at top level.", this.mParser.getTokenLocation());
            }
            ResourceClass klass = Resource.getKlass(text);
            if (klass == null) {
                throw new JsonParseException("Unknown toplevel class '" + text + "'.", this.mParser.getTokenLocation());
            }
            openedResource = parseOpenedResource(klass);
        }
        if (this.mParser.nextToken() != JsonToken.END_OBJECT) {
            throw new JsonParseException("Expected only one k/v in toplevel wrapper object.", this.mParser.getTokenLocation());
        }
        return openedResource;
    }
}
