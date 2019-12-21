#define N 3
int fork[N] = -1;

inline philosopherGetsLeftFork(philosopherNumber)
{
    (fork[philosopherNumber] == -1 && fork[(philosopherNumber+1)%N] == -1)
    printf("philosopher %d gets fork%d...\n", _pid, philosopherNumber);
    fork[philosopherNumber] = philosopherNumber;
}

inline philosopherGetsRightFork(philosopherNumber)
{
    (fork[(philosopherNumber+1)%N] == -1 && fork[philosopherNumber] == philosopherNumber)
    printf("philosopher %d gets fork%d...\n", _pid, philosopherNumber+1);
    fork[(philosopherNumber+1)%N] = philosopherNumber;                                           
}

active [N] proctype Phil() { 
    do
    :: 
    printf("philosopher %d is thinking...\n", _pid);
    atomic
    {
        philosopherGetsLeftFork(_pid);
        philosopherGetsRightFork(_pid);
    }

    (fork[_pid]!=-1 && fork[(_pid+1)%N]!=-1 && fork[_pid] == _pid && fork[(_pid+1)%N] == _pid)
    atomic
    { 
        printf("philosopher %d eats with fork%d and fork%d...\n", _pid, _pid, _pid+1);
        fork[_pid] = -1;
        fork[(_pid+1)%N] = -1;
    }
    od
}