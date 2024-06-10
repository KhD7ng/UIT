#define faster ios_base::sync_with_stdio(false); cin.tie(0); cout.tie(0);
#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define pb push_back
#define spacing cout << '\n';
#define all(x) (x).begin(), (x).end()
#define EACH(u, v) for (auto &u : v)

void solve() {
    // input
    int n, q;
    cin >> n >> q;

    vector<vector<int>> adj(n + 1);
    // dp[i][j] min distance từ i -> j
    vector<vector<int>> dp(n + 1, vector<int>(n + 1, 2e5 + 1));
    
    for(int i = 1; i < n; i++) {
        int u, v;
        cin >> u >> v;  
        adj[u].pb(v);
        adj[v].pb(u);
        dp[u][v] = 1;
        dp[v][u] = 1;
    }

    for(int i = 1; i <= n; i++) 
        dp[i][i] = 0;

    while(q--) {
        int u, v;
        cin >> u >> v;
        cout << dp[1][u] + dp[1][v];
    }
}

int main() {
    // faster;
    solve();
    return 0;
}