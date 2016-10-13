%lop 6
%pulse coupling
clear;

Nosc= 500;
Tmax=20;
tau = 0.1 ;
N_time =Tmax/tau ;

Kmin = 0.5;
Kmax = 5.0;
delta_K = 0.5;
NK = round((Kmax-Kmin)/delta_K)+1;
K = delta_K;
%loop start
r_final = zeros(NK,1);
ik = 1;
%(Uniform distribution from zero to 2*pi)
a=2*pi*rand(1,Nosc);
%Normal distribution with mean = 0, std = 0.5
w = random('Normal',0,0.5,1,Nosc);
%pulse starting point, pmin
pmin = 0;
pmin = mod(pmin,2*pi);
%pulse end point, pmax
pmax = pi;
pmax = mod(pmax,2*pi);
%pulse time width
psize = pmax-pmin;
%initializing count of osicllators pulsating
count = zeros(NK,N_time);
while(K<=(Kmax))
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
        for j = 1:Nosc
            if(theta(t,j) >= pmin && theta(t,j) <= pmax)
                p(j) = 1;
                count(ik,t) = count(ik,t) + 1;
            end                
        end
        for i=1:Nosc            
            for j = 1:Nosc
                theta_dot(t,i) = theta_dot(t,i) + p(j)*(K/Nosc)*sin(theta(t,j)-theta(t,i));         
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
    K = K+delta_K
    ik = ik + 1 ;
    r_final(ik) = r(mean(t-10,(t+1)));
end
 
K = 0:delta_K:Kmax;
plot(K,r_final);