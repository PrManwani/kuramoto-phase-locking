flag=0;
b = 0;
for t = 1:1:9999
%plot(c(t-49:t),count(t-48:t+1),'*');
subplot(2,1,1)
plot(theta_dot(t,:),'*')
if(c(t)<10^-10)
    title('Thetadot-SYNCHRONIZED')
else
    title('Thetadot')
end
subplot(2,1,2)
plot(theta(t,:),'*')
if(count(t+1)==Nosc)
    flag=0;
end
if(count(t+1)<count(t) && flag==1)
    title('Theta-OSCILLATOR LEAVES SYSTEM')
elseif(count(t+1)>count(t) && flag==1)
        title('Theta-OSCILLATOR ENTERS SYSTEM')
else
    title('Theta')
end
if(count(t+1) == 499 && b==0 && t>100)
    pause;
    b = 1;
end
pause(0.5);
end