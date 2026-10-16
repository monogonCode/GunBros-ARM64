package com.openfeint.api.resource;

import com.openfeint.internal.resource.ArrayResourceProperty;
import com.openfeint.internal.resource.BooleanResourceProperty;
import com.openfeint.internal.resource.NestedResourceProperty;
import com.openfeint.internal.resource.Resource;
import com.openfeint.internal.resource.ResourceClass;
import com.openfeint.internal.resource.StringResourceProperty;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class Leaderboard extends Resource {
    public boolean allowsWorseScores;
    public boolean descendingSortOrder = true;
    public List<Score> highScores;
    public Score localUserScore;
    public String name;

    public Leaderboard() {
    }

    public Leaderboard(String str) {
        setResourceID(str);
    }

    public static ResourceClass getResourceClass() {
        ResourceClass resourceClass = new ResourceClass(Leaderboard.class, "leaderboard") { // from class: com.openfeint.api.resource.Leaderboard.4
            @Override // com.openfeint.internal.resource.ResourceClass
            public final Resource factory() {
                return new Leaderboard();
            }
        };
        resourceClass.mProperties.put("name", new StringResourceProperty() { // from class: com.openfeint.api.resource.Leaderboard.5
            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final String get(Resource resource) {
                return ((Leaderboard) resource).name;
            }

            @Override // com.openfeint.internal.resource.StringResourceProperty
            public final void set(Resource resource, String str) {
                ((Leaderboard) resource).name = str;
            }
        });
        resourceClass.mProperties.put("current_user_high_score", new NestedResourceProperty(Score.class) { // from class: com.openfeint.api.resource.Leaderboard.6
            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final Resource get(Resource resource) {
                return ((Leaderboard) resource).localUserScore;
            }

            @Override // com.openfeint.internal.resource.NestedResourceProperty
            public final void set(Resource resource, Resource resource2) {
                ((Leaderboard) resource).localUserScore = (Score) resource2;
            }
        });
        resourceClass.mProperties.put("descending_sort_order", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.Leaderboard.7
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((Leaderboard) resource).descendingSortOrder;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((Leaderboard) resource).descendingSortOrder = z;
            }
        });
        resourceClass.mProperties.put("allow_posting_lower_scores", new BooleanResourceProperty() { // from class: com.openfeint.api.resource.Leaderboard.8
            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final boolean get(Resource resource) {
                return ((Leaderboard) resource).allowsWorseScores;
            }

            @Override // com.openfeint.internal.resource.BooleanResourceProperty
            public final void set(Resource resource, boolean z) {
                ((Leaderboard) resource).allowsWorseScores = z;
            }
        });
        resourceClass.mProperties.put("high_scores", new ArrayResourceProperty(Score.class) { // from class: com.openfeint.api.resource.Leaderboard.9
            @Override // com.openfeint.internal.resource.ArrayResourceProperty
            public final List<? extends Resource> get(Resource resource) {
                return ((Leaderboard) resource).highScores;
            }

            /* JADX WARN: Multi-variable type inference failed */
            @Override // com.openfeint.internal.resource.ArrayResourceProperty
            public final void set(Resource resource, List<?> list) {
                ((Leaderboard) resource).highScores = list;
            }
        });
        return resourceClass;
    }
}
