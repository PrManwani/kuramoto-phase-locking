%lop 6
%pulse coupling
%varying pulse_width
%width matters and not the starting point

Nosc= 100;
Tmax=20;
tau = 0.1 ;
N_time =Tmax/tau ;
K = input('put K')
w = random('Normal',0,0.5,1,Nosc);


runs = 0;
while(runs<20)
%(Uniform distribution from zero to 2*pi)
a=2*pi*rand(1,Nosc);
%Normal distribution with mean = 0, std = 0.5
    
ip = 1;    
pmin = 0;
alpha = 0.05;
delta_p = alpha*2*pi;

NP = round((2*pi)/delta_p);
psize = delta_p;
%loop start
r_final = zeros(NP,1);
%initializing count of osicllators pulsating
count = zeros(NP,N_time);
while(psize<=(2*pi))
    
    
    pmin = 0;
    pmax = psize;
    %Initializing for current K
    theta = zeros(N_time,Nosc);
    theta_dot = zeros(N_time,Nosc);
    r_cos = zeros(N_time,1);
    r_sin = zeros(N_time,1);
    r = zeros(N_time,1);     
    %theta initialization    
    %r initialization
    for j = 1:Nosc
        theta(1,j)=a(j);
        theta(1,j) = mod(theta(1,j),2*pi);
        r_cos(1) = r_cos(1) + (1/Nosc)*cos(theta(1,j));
        r_sin(1) = r_sin(1) + (1/Nosc)*sin(theta(1,j));
    end
    r(1) = sqrt(r_cos(1)^2 + r_sin(1)^2);    
    for t=1:(N_time-1)
        %pulsing oscillators should be inside pmin and pmax
        %defining array for pulsing
        p = zeros(Nosc,1);
        for i = 1:Nosc
            if(theta(t,i) >= pmin && theta(t,i) <= pmax)
                p(i) = 1;
                count(ip,t) = count(ip,t) + 1;
            end                
        end
        for i=1:Nosc            
            for j = 1:Nosc
                theta_dot(t,i) = theta_dot(t,i) + p(i)*(K/Nosc)*sin(theta(t,j)-theta(t,i));         
            end
            theta_dot(t,i) =theta_dot(t,i) + w(i);            
            theta(t+1,i) = theta(t,i) + tau*theta_dot(t,i);
            theta(t+1,i) = mod(theta(t+1,i),2*pi);
            r_cos(t+1) = r_cos(t+1) + (1/Nosc)*cos(theta(t+1,i));
            r_sin(t+1) = r_sin(t+1) + (1/Nosc)*sin(theta(t+1,i));
        end %Euler Done                      
        r(t+1) = sqrt(r_cos(t+1)^2 + r_sin(t+1)^2);
    end
    r_final(1) = r(1);       
    psize = psize+delta_p
    ip = ip + 1;
    r_final(ip)= r(mean(t-10,(t+1)));
end
hold on
figure(2) 
p = 0:delta_p:2*pi;
plot(p,r_final);
runs = runs + 1;
pause;
end