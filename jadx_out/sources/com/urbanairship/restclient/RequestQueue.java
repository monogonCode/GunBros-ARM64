package com.urbanairship.restclient;

import com.urbanairship.Logger;
import java.util.HashMap;
import java.util.LinkedList;

/* JADX INFO: loaded from: classes.dex */
public class RequestQueue {
    private int maxConcurrentRequests = 3;
    private int runningRequests = 0;
    private LinkedList<Request> requests = new LinkedList<>();
    private HashMap<Request, AsyncHandler> handlers = new HashMap<>();

    /* JADX INFO: Access modifiers changed from: private */
    public synchronized void removeRequest(Request request) {
        Logger.verbose("removing request " + request.getURI());
        this.handlers.remove(request);
        this.runningRequests--;
        update();
    }

    private void runRequest(final Request request) {
        Logger.verbose("running request " + request.getURI());
        this.runningRequests++;
        final AsyncHandler asyncHandler = this.handlers.get(request);
        try {
            request.executeAsync(new AsyncHandler() { // from class: com.urbanairship.restclient.RequestQueue.1
                @Override // com.urbanairship.restclient.AsyncHandler
                public void onComplete(Response response) {
                    RequestQueue.this.removeRequest(request);
                    asyncHandler.onComplete(response);
                }

                @Override // com.urbanairship.restclient.AsyncHandler
                public void onError(Exception exc) {
                    RequestQueue.this.removeRequest(request);
                    asyncHandler.onError(exc);
                }

                @Override // com.urbanairship.restclient.AsyncHandler
                public void onProgress(int i) {
                    asyncHandler.onProgress(i);
                }
            });
        } catch (Exception e) {
            Logger.error("Error running request", e);
            asyncHandler.onError(e);
            removeRequest(request);
        }
    }

    private void update() {
        while (this.runningRequests < this.maxConcurrentRequests && !this.requests.isEmpty()) {
            runRequest(this.requests.poll());
        }
    }

    public synchronized void addRequest(Request request, AsyncHandler asyncHandler) {
        Logger.verbose("adding request " + request.getURI());
        this.requests.add(request);
        this.handlers.put(request, asyncHandler);
        update();
    }

    public int getMaxConcurrentRequests() {
        return this.maxConcurrentRequests;
    }

    public void setMaxConcurrentRequests(int i) {
        this.maxConcurrentRequests = i;
    }
}
