package com.urbanairship;

import android.content.Context;
import android.content.res.AssetManager;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.ListIterator;
import java.util.Properties;

/* JADX INFO: loaded from: classes.dex */
public abstract class Options {
    public abstract String getDefaultPropertiesFilename();

    public abstract boolean isValid();

    public void loadFromProperties(Context context) {
        loadFromProperties(context, getDefaultPropertiesFilename());
    }

    public void loadFromProperties(Context context, String str) {
        AssetManager assets = context.getResources().getAssets();
        try {
            if (!Arrays.asList(assets.list("")).contains(str)) {
                Logger.verbose("Options - Couldn't find " + str);
                return;
            }
            Properties properties = new Properties();
            try {
                properties.load(assets.open(str));
                ListIterator listIterator = Arrays.asList(getClass().getDeclaredFields()).listIterator();
                while (listIterator.hasNext()) {
                    Field field = (Field) listIterator.next();
                    String property = properties.getProperty(field.getName());
                    if (property != null) {
                        try {
                            if (field.getType() == Boolean.TYPE || field.getType() == Boolean.class) {
                                field.set(this, Boolean.valueOf(property));
                            } else {
                                try {
                                    field.set(this, property.trim());
                                } catch (IllegalArgumentException e) {
                                    Logger.error("Unable to set field '" + field.getName() + "' due to type mismatch.");
                                }
                            }
                        } catch (IllegalAccessException e2) {
                            Logger.error("Unable to set field '" + field.getName() + "' because the field is not visible.");
                        }
                    }
                }
            } catch (IOException e3) {
                Logger.error("Error loading properties file " + str, e3);
            }
        } catch (IOException e4) {
            Logger.error(e4);
        }
    }
}
