hold on
flag = 0
plot(c(120:2000),count(121:2001))
for t = 120:2000
%plot(c(t-49:t),count(t-48:t+1),'*');
plot(c(t),count(t+1),'*','markers',10)
if(count(t+1) == 489)
    flag = 1;
end
if(flag==0)
    axis([0 0.0024 488 500])
else
    axis([0 0.002 489 490])   
end
pause(0.2);

end