%lop 6
%pulse coupling influencing
clear;

Nosc= 500;
Tmax=500;
tau = 0.1 ;
N_time =Tmax/tau ;

K = 5;
%loop start
ik = 1;
%(Uniform distribution from zero to 2*pi)
a=2*pi*rand(1,Nosc);
%Normal distribution with mean = 0, std = 0.5
w = random('Normal',0,0.5,1,Nosc);
%pulse starting point, pmin
for alpha = 1:10
pmin = 0;
pmin = mod(pmin,2*pi);
%pulse end point, pmax
pmax = 0.1*alpha*2*pi-0.001;
pmax = mod(pmax,2*pi);
%pulse time width
psize = pmax-pmin;
%initializing count of osicllators pulsating
%count = zeros(NK,N_time);
    %Initializing for current K
    theta = zeros(N_time,Nosc);
    theta_dot = zeros(N_time,Nosc);
    r_cos = zeros(N_time,1);
    r_sin = zeros(N_time,1);
    r = zeros(N_time,1);
    count = zeros(N_time,1);
    %theta initialization    
    %r initialization
    for j = 1:Nosc
        theta(1,j)=a(j);
        theta(1,j) = mod(theta(1,j),2*pi);
        r_cos(1) = r_cos(1) + (1/Nosc)*cos(theta(1,j));
        r_sin(1) = r_sin(1) + (1/Nosc)*sin(theta(1,j));        
        if(theta(1,j) >= pmin && theta(1,j) <= pmax)
            count(1) = count(1) + 1;
        end
    end
    r(1) = sqrt(r_cos(1)^2 + r_sin(1)^2); 
    p = zeros(Nosc,N_time-1);
    for t=1:(N_time-1)
        %pulsing oscillators should be inside pmin and pmax
        %defining array for pulsing
        
        for j = 1:Nosc
            if(theta(t,j) >= pmin && theta(t,j) <= pmax)
                p(j,t) = 1;
                count(t+1) = count(t+1) + 1;
            end                
        end
        for i=1:Nosc            
            for j = 1:Nosc
                theta_dot(t,i) = theta_dot(t,i) + p(j,t)*(K/Nosc)*sin(theta(t,j)-theta(t,i));         
            end
            theta_dot(t,i) =theta_dot(t,i) + w(i);            
            theta(t+1,i) = theta(t,i) + tau*theta_dot(t,i);
            theta(t+1,i) = mod(theta(t+1,i),2*pi);
            r_cos(t+1) = r_cos(t+1) + (1/Nosc)*cos(theta(t+1,i));
            r_sin(t+1) = r_sin(t+1) + (1/Nosc)*sin(theta(t+1,i));
        end %Euler Done                      
        r(t+1) = sqrt(r_cos(t+1)^2 + r_sin(t+1)^2);
    end
    figure(alpha)
    plot(theta_dot(4999,:),'*');
end
   
 
