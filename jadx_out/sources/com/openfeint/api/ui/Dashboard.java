package com.openfeint.api.ui;

import android.content.Intent;
import android.content.res.Resources;
import android.view.Menu;
import android.view.MenuItem;
import com.openfeint.api.Notification;
import com.openfeint.internal.OpenFeintInternal;
import com.openfeint.internal.RR;
import com.openfeint.internal.eventlog.EventLogDispatcher;
import com.openfeint.internal.notifications.TwoLineNotification;
import com.openfeint.internal.offline.OfflineSupport;
import com.openfeint.internal.ui.Settings;
import com.openfeint.internal.ui.WebNav;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class Dashboard extends WebNav {
    private static String openfrom;
    private static List<Dashboard> sOpenDashboards = new ArrayList();
    boolean mRootIsHome = true;

    private class DashboardActionHandler extends WebNav.ActionHandler {
        public DashboardActionHandler(WebNav webNav) {
            super(webNav);
        }

        public final void openSettings(Map<String, String> map) {
            Settings.open();
        }

        @Override // com.openfeint.internal.ui.WebNav.ActionHandler
        protected void populateActionList(List<String> list) {
            super.populateActionList(list);
            list.add("openSettings");
        }
    }

    public static void open() {
        open(null, false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void open(String str, boolean z) {
        OfflineSupport.trySubmitOfflineData();
        OpenFeintInternal openFeintInternal = OpenFeintInternal.getInstance();
        if (!openFeintInternal.isFeintServerReachable()) {
            Resources resources = OpenFeintInternal.getInstance().getContext().getResources();
            TwoLineNotification.show(resources.getString(RR.string("of_offline_notification")), resources.getString(RR.string("of_offline_notification_line2")), Notification.Category.Foreground, Notification.Type.NetworkOffline);
            return;
        }
        EventLogDispatcher.getInstance().postEvent("dashboard_start.openfeint.com", openfrom);
        Intent intent = new Intent(openFeintInternal.getContext(), (Class<?>) Dashboard.class);
        if (str != null) {
            intent.putExtra("screenName", str);
        }
        openFeintInternal.submitIntent(intent, z);
    }

    public static void openAchievements() {
        open("achievements", false);
    }

    public static void openFromSpotlight() {
        open("user.json?spotlight=true", true);
    }

    public static void openUser(String str) {
        open("profile.json?user_id=" + str, false);
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected WebNav.ActionHandler createActionHandler(WebNav webNav) {
        return new DashboardActionHandler(webNav);
    }

    @Override // com.openfeint.internal.ui.WebNav
    protected String initialContentPath() {
        String stringExtra = getIntent().getStringExtra("screenName");
        if (stringExtra == null) {
            return "dashboard/user";
        }
        this.mRootIsHome = false;
        return "dashboard/" + stringExtra;
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(RR.menu("of_dashboard"), menu);
        return true;
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    public void onDestroy() {
        super.onDestroy();
        sOpenDashboards.remove(this);
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        String str = null;
        if (menuItem.getItemId() == RR.id("home")) {
            str = "home";
            this.mRootIsHome = true;
        } else if (menuItem.getItemId() == RR.id("settings")) {
            str = "settings";
        } else if (menuItem.getItemId() == RR.id("exit_feint")) {
            str = "exit";
        }
        if (str == null) {
            return super.onOptionsItemSelected(menuItem);
        }
        executeJavascript(String.format("OF.menu('%s')", str));
        return true;
    }

    @Override // android.app.Activity
    public boolean onPrepareOptionsMenu(Menu menu) {
        menu.findItem(RR.id("home")).setVisible(!this.mRootIsHome || this.pageStackCount > 1);
        return true;
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    public void onResume() {
        super.onResume();
        if (!sOpenDashboards.contains(this)) {
            sOpenDashboards.add(this);
        }
        if (OpenFeintInternal.getInstance().getCurrentUser() == null) {
            finish();
        }
    }

    @Override // com.openfeint.internal.ui.WebNav, android.app.Activity
    public void onStop() {
        EventLogDispatcher.getInstance().postEvent("dashboard_end.openfeint.com", openfrom);
        super.onStop();
    }
}
