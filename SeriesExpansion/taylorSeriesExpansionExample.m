clc; clear; close all; 
syms x;
f = 1 - x^2/2*cos(x) - x/2*sin(x);
T6 = taylor(f,x)
T8 = taylor(f,x,'Order', 8)
T10 = taylor(f, x, 'Order', 10)
fplot(f, [0.1 1], LineWidth=2);
hold on;
fplot(T6, [0.1 1], '--or');
fplot(T8, [0.1 1], '-.*c');
fplot(T10, [0.1 1], '--xm');
%xlim([-4 4])
grid on
legend('f(x)', ...
       'approximation of f(x) with error O(x^6)', ...
       'approximation of f(x) with error O(x^8)', ...
       'approximation of f(x) with error O(x^{10})')
title('Taylor Series Expansion')
hold off;
t = 0.1:1e-4:1;
hF = matlabFunction(f); y = hF(t);
hF6 = matlabFunction(T6); y6 = hF6(t);
hF8 = matlabFunction(T8); y8 = hF8(t);
hF10 = matlabFunction(T10); y10 = hF10(t);
figure;
plot(t, abs(y8-y), '-.c', t, abs(y10-y), 'm', LineWidth=2), grid;
legend('residual O(x^8)', 'residual O(x^{10})'); title('Residual Expansion');
% plot(t, abs(y6-y), '--r', t, abs(y8-y), '-.c', t, abs(y10-y), 'm'), grid;
% legend('residual O(x^6)', 'residual O(x^8)', 'residual O(x^{10})'); title('Residual Expansion');

% using common member formula
common6 = taylorNth(t, 2);
figure;
plot(t, y, '-.c', t, common6, '-k'), grid;
title('Common member formula approximation');
legend('f(x)', 'approximation of f(x) with error O(x^6)')

function value = taylorNth(x, N)
    value = zeros(1, length(x));
%     for i = 1:length(x)
%          value(i) = x(i)^(4./3.0) - x(i)^2 + 1.0;
%     end
%     value = x.^(4.0/3.0) - x.^2 + 1.0;
    for n = 0:N 
        value = value + (-1)^n * 2*n^2 * x.^(2*n) / factorial(2*n);
    end
    value = value + 1;
end


