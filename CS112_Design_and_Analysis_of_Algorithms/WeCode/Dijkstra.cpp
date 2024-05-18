#define faster ios_base::sync_with_stdio(false); cin.tie(0); cout.tie(0);
#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define pb push_back
#define spacing cout << '\n' << '\n' << '\n';

void solve() {
    int v, n;
    cin >> v >> n;

    spacing;    
    vector<string> vertices(v);
    map<string, int> mappingIndex;

    for (int i = 0; i < v; i++) {
        cin >> vertices[i];
        mappingIndex[vertices[i]] = i;
    }

    vector<vector<int>> adj(v, vector<int>(v));
    for (int i = 0; i < v; i++) {
        for (int j = 0; j < v; j++) {
            cin >> adj[i][j];
        }
    }

    for (int i = 0; i < n; i++) {
        string s, e;
        cin >> s >> e;
        
        vector<int> dis(v, INT_MAX); // Lưu khoảng cách từ start -> curNode
        dis[mappingIndex[s]] = 0;

        // <distance, nodeIndex>
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> q;
        vector<bool> visited(v, 0);
        vector<int> parent(v, -1);

        q.push({0, mappingIndex[s]});
        int maxQueueSize = 1;
        
        while (q.size()) {
            int curNode = q.top().second;
            q.pop();

            if (visited[curNode]) continue;
            visited[curNode] = 1;
            maxQueueSize++;
            
            for (int j = 0; j < v; j++) {
                if (adj[curNode][j] && !visited[j]) {
                    int weight = adj[curNode][j];
                    if (dis[curNode] + weight < dis[j]) {
                        dis[j] = dis[curNode] + weight;
                        parent[j] = curNode;
                        q.push({dis[j], j});
                    }
                }
            }
        }

        vector<string> path;
        for (int at = mappingIndex[e]; at != -1; at = parent[at]) {
            path.pb(vertices[at]);
        }
        reverse(path.begin(), path.end());

        if(dis[mappingIndex[e]] == INT_MAX) {
            cout << "-unreachable-" << '\n';
            cout << maxQueueSize << ' ' << 0 << '\n';
        } else {
            for (const string &node : path) {
                cout << node << ' ';
            }
            cout << '\n';
            cout << maxQueueSize << ' ' << dis[mappingIndex[e]] << '\n';
        }
    }
}

int main() {
    faster;
    solve();
    return 0;
}
