#define faster ios_base::sync_with_stdio(false), cin.tie(0), cout.tie(0);
#define ll long long
#include <bits/stdc++.h>
using namespace std;

bool cmp(const pair<int, int>& a, const pair<int, int>& b) {
    return a.first > b.first;
}

void solve() {
    int numJob, numMachine;
    vector<pair<int, int>> job;
    cin >> numJob >> numMachine;
    job.resize(numJob);
    for(int i = 0; i < numJob; i++) {
        cin >> job[i].first;
        job[i].second = i;
    }

    // Bài toán cần sort, sau đó tìm cách chọn tối ưu
    sort(job.begin(), job.end(), cmp);

    // Test
    for(auto i : job)
        cout << i.first << ' ';

    // Process
    vector<vector<ll>> totalTime;
    vector<vector<vector<ll>>> dp;
    
}

int main()
{
    faster;
	solve();
	return 0;
}