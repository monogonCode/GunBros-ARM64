package com.urbanairship.push.embedded;

/* JADX INFO: loaded from: classes.dex */
public class Config {

    public static class BoxOffice {
        public static final long MAX_HOLDING_PATTERN = 604800;
        public static String url = "https://boxoffice.urbanairship.com";
    }

    public static class Helium {
        public static final long backoffFactor = 2;
        public static final long initialRetryInterval = 10000;
        public static final int maxFailureCount = 3;
        public static final long maxRetryInterval = 640000;
        public static final long postLookupDelay = 3000;
        public static final long readSleep = 100;
        public static final long retryResetThreshold = 180000;
        public static long max_keepalive_interval = 300000;
        public static final long MAX_HELIUM_CACHE_TTL_MS = 86400000;
        public static long heliumCacheTTL = MAX_HELIUM_CACHE_TTL_MS;
        public static long minHeliumCacheTTL = 3600000;
    }
}
