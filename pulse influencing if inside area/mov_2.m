hold on
plot(c(2:250),count(1:249))
for t = 1:1:250
%plot(c(t-49:t),count(t-48:t+1),'*');
plot(c(t),count(t+1),'*','markers',10)
axis([0 2 0 500])
pause(0.5);
end
