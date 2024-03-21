clear all
close all
clc

% dane
y1 = [1.8; 2.5];
y2 = [2.0; 1.7];
y3 = [1.5; 1.5];
y4 = [1.5; 2.0];
y5 = [2.5; 1.5];

y = [y1,y2,y3,y4,y5]';

d1 = 2.0;
d2 = 1.24;
d3 = 0.59;
d4 = 1.31;
d5 = 1.41;

d = [d1, d2, d3, d4, d5];
g = -2*transpose(y1);

A = [
  -2*(y1'), 1;
  -2*(y2'), 1;
  -2*(y3'), 1;
  -2*(y4'), 1;
  -2*(y5'), 1
];

b = [
    d1^2 - norm(y1)^2;
    d2^2 - norm(y2)^2;
    d3^2 - norm(y3)^2;
    d4^2 - norm(y4)^2;
    d5^2 - norm(y5)^2
];

Q = [
  [1,0,0]
  [0,1,0]
  [0,0,0]
];

c = [0;0;-0.5];

 

cvx_begin quiet sdp
    variable t;
    variable u;
    % wzór 8
    minimize(t - norm(b)^2)
    subject to
        [A' * A + u * Q, A' * b - u * c;
        (A' * b - u * c)', t] >= 0; 
cvx_end

% równanie 7
A1 = A'*A + u*Q;
b1 = A'*b - u*c;
z = inv(A1)*b1;

%rozwiązanie
x = [z(1), z(2)]



s = 100;
X = linspace(0,3,s);
Y = linspace(0,3,s);
[X,Y] = meshgrid(X,Y);
Z = zeros(s);
for i = 1:s
    for j=1:s
        ts = 0;
        xa = X(i,j);
        ya = Y(i,j);
        % wzór 1
        for k = 1:5
            ts = ts + (norm([xa - y(k,1), ya - y(k,2)])^2 - d(k)^2)^2;
        end
        Z(i,j) = ts;
    end

end 

% czerwony marker - źródło sygnału
% czarne markery - sensory
figure
contourf(X, Y, Z, 200);
hold on
scatter3(z(1), z(2), 0, 'r', 'filled');
scatter3(y1(1), y1(2), 0, 'black', 'filled')
scatter3(y2(1), y2(2), 0, 'black', 'filled')
scatter3(y3(1), y3(2), 0, 'black', 'filled')
scatter3(y4(1), y4(2), 0, 'black', 'filled')
scatter3(y5(1), y5(2), 0, 'black', 'filled')
hold off