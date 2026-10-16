package com.openfeint.internal;

import android.content.res.Resources;

/* JADX INFO: loaded from: classes.dex */
public final class RR {
    private static Resources _resources = null;
    private static String _packageName = null;

    public static final int drawable(String str) {
        return identifier(str, "drawable");
    }

    public static final int id(String str) {
        return identifier(str, "id");
    }

    private static final int identifier(String str, String str2) {
        if (_resources == null) {
            _resources = OpenFeintInternal.getInstance().getContext().getResources();
        }
        Resources resources = _resources;
        if (_packageName == null) {
            _packageName = OpenFeintInternal.getInstance().getContext().getPackageName();
        }
        return resources.getIdentifier(str, str2, _packageName);
    }

    public static final int layout(String str) {
        return identifier(str, "layout");
    }

    public static final int menu(String str) {
        return identifier(str, "menu");
    }

    public static final int string(String str) {
        return identifier(str, "string");
    }

    public static final int style(String str) {
        return identifier(str, "style");
    }
}
