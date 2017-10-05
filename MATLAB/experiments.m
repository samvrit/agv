% test

clc
clear

A = magic(4)

array2table(A, 'RowNames' , {'A','B','C','D'}, 'VariableNames', {'P','Q','R','S'})