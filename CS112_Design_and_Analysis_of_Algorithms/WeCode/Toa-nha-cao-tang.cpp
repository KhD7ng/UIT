#define faster ios_base::sync_with_stdio(false); cin.tie(0); cout.tie(0);
#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define pb push_back
#define spacing cout << '\n';
#define all(x) (x).begin(), (x).end()
#define EACH(u, v) for (auto &u : v)

struct arr {
    int x1, x2, h;
};

bool x2Desc(arr& a, arr& b) {
    return a.x2 < b.x2; // x2 tăng
}

void solve() {
    // input
    int n;
    cin >> n;
    vector<arr> a(n + 1);
    vector<pair<int,int>> ans; // x, h

    for(int i = 1; i <= n; i++) {
        cin >> a[i].x1 >> a[i].x2 >> a[i].h;   
    }

    // Test
    // EACH(u, a)
    //     cout << u.x1 << ' ' << u.x2 << ' ' << u.h << '\n';

    // xử lí intersect ----------------------------------------> Not done
    for(int i = 1; i <= n; i++) {
        
    }

    ans.pb({a[1].x1, a[1].h}); // điểm đầu tiên luôn tạo được 1 point

    // xử lí trái trên ----------------------------------------> Done
    int lastIdx = 1; // toà cao nhất là toà đầu tiên
    int mostRight = a[1].x2; // x2 max
    for(int i = 2; i <= n; i++) {
        // nếu qua 1 cụm mới
        if(a[i].x1 > mostRight) { 
            mostRight = a[i].x2;
            ans.pb({a[i].x1, a[i].h});
            lastIdx = i;
            continue;
        } else {
        // nếu trong 1 cụm
            if(a[i].h > a[lastIdx].h) {
                ans.pb({a[i].x1, a[i].h});
                lastIdx = i;
                continue;
            }

            if(a[i].h == a[lastIdx].h) {
                if(a[i].x1 > a[lastIdx].x2) {
                    ans.pb({a[i].x1, a[i].h});
                    lastIdx = i;
                    continue;
                }
            }
        }

        mostRight = max(mostRight, a[i].x2);
    } 
    
    // xử lí phải dưới ----------------------------------------> Done
    sort(all(a), x2Desc);
    ans.pb({a[n].x2, 0});
    
    int mostLeft = a[n].x1;
    int tallest = n; // toà cao nhất là n
    for(int i = n-1; i >= 1; i--) {
        // nếu qua 1 cụm mới
        if(a[i].x2 < mostLeft) {
            ans.pb({a[i].x2, 0});
            mostLeft = a[i].x1;
            tallest = i;
            continue;
        }
        mostLeft = min(mostLeft, a[i].x1);
    }

    sort(all(ans));

    EACH(u, ans)
        cout << u.first << ' ' << u.second << '\n';
}

int main() {
    // faster;
    solve();
    return 0;
}