package com.openfeint.internal.ui;

import android.content.Intent;
import android.graphics.Bitmap;
import com.openfeint.internal.ImagePicker;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.Util5;
import com.openfeint.internal.request.IRawRequestDelegate;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class IntroFlow extends WebNav {
    Bitmap cachedImage;

    private class IntroFlowActionHandler extends WebNav.ActionHandler {
        public IntroFlowActionHandler(WebNav webNav) {
            super(webNav);
        }

        public final void cacheImage(Map<String, String> map) {
            ImagePicker.show(IntroFlow.this);
        }

        public final void clearImage(Map<String, String> map) {
            IntroFlow.this.cachedImage = null;
        }

        public final void createUser(final Map<String, String> map) {
            OpenFeintInternal.getInstance().createUser(map.get("name"), map.get("email"), map.get("password"), map.get("password_confirmation"), new IRawRequestDelegate() { // from class: com.openfeint.internal.ui.IntroFlow.IntroFlowActionHandler.1
                @Override // com.openfeint.internal.request.IRawRequestDelegate
                public final void onResponse(int i, String str) {
                    IntroFlowActionHandler.this.mWebNav.executeJavascript(String.format("%s('%d', %s)", map.get("callback"), Integer.valueOf(i), str.trim()));
                }
            });
        }

        public void decline(Map<String, String> map) throws Throwable {
            OpenFeintInternal.getInstance().userDeclinedFeint();
            IntroFlow.this.finish();
        }

        public void getEmail(Map<String, String> map) {
            String accountNameEclair = Util5.getAccountNameEclair(IntroFlow.this);
            if (accountNameEclair != null) {
                IntroFlow.this.executeJavascript(String.format("%s('%s');", map.get("callback"), accountNameEclair));
            }
        }

        public final void loginUser(final Map<String, String> map) {
            OpenFeintInternal.getInstance().loginUser(map.get("email"), map.get("password"), map.get("user_id"), new IRawRequestDelegate() { // from class: com.openfeint.internal.ui.IntroFlow.IntroFlowActionHandler.2
                @Override // com.openfeint.internal.request.IRawRequestDelegate
                public final void onResponse(int i, String str) {
                    IntroFlowActionHandler.this.mWebNav.executeJavascript(String.format("%s('%d', %s)", map.get("callback"), Integer.valueOf(i), str.trim()));
                }
            });
        }

        @Override // com.openfeint.internal.ui.WebNav.ActionHandler
        protected void populateActionList(List<String> list) {
            super.populateActionList(list);
            list.add("createUser");
            list.add("loginUser");
            list.add("cacheImage");
            list.add("uploadImage");
            list.add("clearImage");
            list.add("decline");
            list.add("getEmail");
        }

        public final void uploadImage(Map<String, String> map) {
            if (IntroFlow.this.cachedImage != null) {
                ImagePicker.compressAndUpload(IntroFlow.this.cachedImage, "/xp/users/" + OpenFeintInternal.getInstance().getCurrentUser().resourceID() + "/profile_picture", null);
            }
        }
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected WebNav.ActionHandler createActionHandler(WebNav webNav) {
        return new IntroFlowActionHandler(webNav);
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected String initialContentPath() {
        String stringExtra = getIntent().getStringExtra("content_name");
        return stringExtra != null ? "intro/" + stringExtra : "intro/index";
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    public void onActivityResult(int i, int i2, Intent intent) {
        if (ImagePicker.isImagePickerActivityResult(i)) {
            this.cachedImage = ImagePicker.onImagePickerActivityResult$1de9c2be(this, i2, intent);
        }
    }
}
