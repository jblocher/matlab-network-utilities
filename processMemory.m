function mem = processMemory(S)
% takes a whos memory structure and processes it to sum all the values up
% to a single memory number.
b = 0;
for i = 1:length(S)
    s = S(i,1);
    b = b + s.bytes;
end;
mem = b/1000000;%megabytes