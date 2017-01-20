i = 0
for b = 0.01:0.01:1
    i = i+1;
    phi = b*2*pi;
    wa = 1;
    theta_m = 0.2*2*pi;
    ca = 1/100;
    ta(i) = - ca*cos(theta_m-phi) + ca*cos(phi);
end
b = 0.01:0.01:1;
phi = b*2*pi;
plot(phi,ta);
