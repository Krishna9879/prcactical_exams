#include <stdio.h>

int main() {
    int n;

    printf("Enter number of processes: ");
    scanf("%d", &n);

    int at[n], bt[n], pr[n];
    int ct[n], tat[n], wt[n], completed[n];

    // Input
    for(int i = 0; i < n; i++) {
        printf("Enter AT, BT, Priority for P%d: ", i+1);
        scanf("%d %d %d", &at[i], &bt[i], &pr[i]);
        completed[i] = 0;
    }

    int time = 0, done = 0;
    float total_wt = 0, total_tat = 0;

    while(done < n) {
        int pos = -1;
        int min_pr = 9999;

        // Find highest priority (lowest number)
        for(int i = 0; i < n; i++) {
            if(at[i] <= time && completed[i] == 0) {
                if(pr[i] < min_pr) {
                    min_pr = pr[i];
                    pos = i;
                }
            }
        }

        if(pos == -1) {
            time++; // CPU idle
        } else {
            time += bt[pos];
            ct[pos] = time;

            tat[pos] = ct[pos] - at[pos];
            wt[pos] = tat[pos] - bt[pos];

            total_wt += wt[pos];
            total_tat += tat[pos];

            completed[pos] = 1;
            done++;
        }
    }

    // Output
    printf("\nP\tAT\tBT\tPR\tCT\tTAT\tWT\n");
    for(int i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
               i+1, at[i], bt[i], pr[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Waiting Time = %.2f", total_wt / n);
    printf("\nAverage Turnaround Time = %.2f\n", total_tat / n);

    return 0;
}