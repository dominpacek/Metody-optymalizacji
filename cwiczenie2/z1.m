% Nina Łabęcka 311339 grupa czwartek 14:15
% Dominika Pacek 311378 grupa czwartek 18:15

dane = load('isoPerimData.mat');


C = dane.C;
F = dane.F;
L = dane.L;
N = dane.N;
a = dane.a;
y_fixed = dane.y_fixed;

h = a/N;

% minimalizacja pola pod krzywą
cvx_begin quiet
    variable fa(N + 1, 1);
    % 16a
    minimize( h * sum(fa) );
    
    subject to
        % 16b
        length = 0;
        for i = 1:N
            length = length + norm([h; fa(i + 1) - fa(i)]);
        end
        length <= L;
        % 16c
        abs((fa(3:end) - 2 * fa(2:end-1) + fa(1:end-2)) / h^2) <= C;
        % 16d
        fa(1) == 0;
        % 16e
        fa(N + 1) == 0;
        % 16f
        fa(F) == y_fixed(F);
cvx_end


% minimalizacji pola pod krzywą przy nieujemnych zmiennych optymalizacyjnych
cvx_begin quiet
    variable fb(N + 1, 1);

    % 16a
    minimize( h * sum(fb) );
    
    subject to
        % 16b
        length = 0;
        for i = 1:N
            length = length + norm([h; fb(i + 1) - fb(i)]);
        end
        length <= L;
        % 16c
        abs((fb(3:end) - 2 * fb(2:end-1) + fb(1:end-2)) / h^2) <= C;

        % 16d
        fb(1) == 0;

        % 16e
        fb(N + 1) == 0;

        % 16f
        fb(F) == y_fixed(F);

        % nieujemne zmienne optymalizacyjne
        fb >= 0
cvx_end

% maksymalizacji pola pod krzywą przy usunięciu ograniczenia 
% na maksymalną krzywiznę.
cvx_begin quiet
    variable fc(N + 1, 1);
    % 16a
    maximize( h * sum(fc) );
    
    subject to
        % 16b
        length = 0;
        for i = 1:N
            length = length + norm([h; fc(i + 1) - fc(i)]);
        end
        length <= L
        
        % brak 16c

        % 16d
        fc(1) == 0
        % 16e
        fc(N + 1) == 0
        % 16f
        fc(F) == y_fixed(F);
cvx_end

% wzór 8
fprintf('a) A = %f \n', h * sum(fa(:, 1)));
fprintf('b) A = %f \n', h * sum(fb(:, 1)));
fprintf('c) A = %f \n', h * sum(fc(:, 1)));

x = linspace(0, a, N + 1);

plots = 3;
subplot(1,plots,1);
draw_plot(x, fa, F, y_fixed, 'a)')
subplot(1,plots,2);
draw_plot(x, fb, F, y_fixed, 'b)')
subplot(1,plots,3);
draw_plot(x, fc, F, y_fixed, 'c)')

function draw_plot(x, f, F, y_fixed, title)
    % Linia
    plot(x, f(:, 1));
    hold on;
    grid on;
    xlabel('x/a');
    ylabel('y(x)');
    % Punkty
    plot(x(F), y_fixed(F), '.');
end


