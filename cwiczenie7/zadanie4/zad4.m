% Nina Łabęcka 311339 grupa czwartek 14:15
% Dominika Pacek 311378 grupa czwartek 18:15

close all
clear all
clc
nfontslatex = 18;
nfonts = 14;

load("twoInertialData")
k_max = 35;

% wzór 55
h = @(x, t) x(1) * (1 - (1 / (x(2) - x(3))) * ((x(2) * exp(-t/x(2))) - (x(3) * exp(-t/x(3)))) )
f = @(x) x(1) * (1 - (1 / (x(2) - x(3))) * ((x(2) * exp(-t/x(2))) - (x(3) * exp(-t/x(3)))) ) - y

x0 = [1.1 1.2 1.3];
n = length(x0);

% 56a 56b 56c
J = @(x) [1 - (1 / (x(2) - x(3))) * (x(2) * exp(-t/x(2)) - x(3) * exp(-t/x(3))) (x(1) / (x(3) - x(2))) * (t / x(2) .* exp(-t/x(2)) + (x(3) /(x(2) - x(3))) * (exp(-t/x(3)) - exp(-t/x(2)))) (x(1) / (x(2) - x(3))) * (t / x(3) .* exp(-t/x(3)) + (x(2) /(x(3) - x(2))) * (exp(-t/x(2)) - exp(-t/x(3))))
]

% Lavenberg-Matquardt Algorithm
X = zeros(n,k_max+1);
X(:,1) = x0;
L = 1.0;
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
plot01 = plot(t,y,"s","MarkerEdgeColor","r","MarkerFaceColor","r");
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
