function yfixed = fixy(y)
%%
%%
%%

yfixed = zeros(10,size(y,1));

for i = 1:size(y,1)
    pos = y(i,1);
    yfixed(pos,i) = 1;
endfor
