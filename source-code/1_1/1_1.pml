bool turn, flag [2];
byte ghost;
active [2] proctype P() 
{
   non_cs:
        flag[_pid] = 1;
        turn = 1 - _pid;
        (!flag[1 - _pid] || turn == _pid);

    cs:
        ghost++;
        assert(ghost<=1);
        ghost--;
        skip;

    exit:
        flag[_pid] = 0; 
        goto non_cs;
}
