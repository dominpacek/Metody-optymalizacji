% Nina Łabęcka 311339 grupa czwartek 14:15
% Dominika Pacek 311378 grupa czwartek 18:15

close all
clear all
clc
nfontslatex = 18;
nfonts = 14;

load("reductionData.mat")
k_max = 570;

% 60
h = @(x, t) x(1) * (1 - exp(-x(2)*t) .* (cos(x(3)*t) + (x(2)/x(3)) * sin(x(3)*t)));
% 65
f = @(x) x(1) * (1 - exp(-x(2) * t) .* (cos(x(3) * t) + (x(2) / x(3)) * sin(x(3) * t))) - y;

x0 = [1 1 1]; % initial values of model parameters
n = length(x0);

% wzór [67a 67b 67c]
J = @(x) [1 - exp(-x(2)*t).*(cos(x(3)*t)+(x(2)/x(3))*sin(x(3)*t)) x(1)*exp(-x(2)*t).*(t.*cos(x(3)*t) - ((1 - t*x(2))/x(3)).*sin(x(3)*t)) x(1)*exp(-x(2)*t).*((t+(x(2)/x(3)^2)).*sin(x(3)*t) - (x(2)/x(3))*t.*cos(x(3)*t))];

% algorytm LM
X = zeros(n,k_max+1);
X(:,1) = x0;
L = 0.5;
for k = 1:k_max
    x = X(:,k);
    xNew = x - inv(transpose(J(x)) * J(x) + L * eye(n)) * transpose(J(x)) * f(x);
    if ( norm(f(xNew)) < norm(f(x0)) )
        X(:,k+1) = xNew;
        L = 0.8*L;
    else
        X(:,k+1) = x;
        L = 2*L;
    end
end
xOptimal = X(:,end)




figure
plot01 = plot(t,y,"r","MarkerEdgeColor","r","MarkerFaceColor","r","LineWidth",2);
hold on
tPlot = linspace(t(1),t(end),1e+3);
plot02 = plot(tPlot,h(x0,tPlot),"b","LineWidth",2);
hold on
plot03 = plot(tPlot,h(xOptimal,tPlot),"k","LineWidth",2);

legend([plot01,plot02,plot03],"measurement", "first guess", "final fit")
grid on
set(gca,"FontSize",nfonts);
ylabel("$y = A\sin(\omega t + \phi)$ [a.u.]","Interpreter","Latex","FontSize",nfontslatex)
xlabel("$t$ [s]","Interpreter","Latex","FontSize",nfontslatex)