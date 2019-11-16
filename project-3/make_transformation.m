function [x_co, y_co] = make_transformation(M, X1, Y1, X2, Y2, kernel)
% Computes the x and y coefficients used in the transformation, based on
% the correspondences in X1, Y1, X2, and Y2, and the input kernel.

% Calculates each norm to be used as input to phi
points = [X1 Y1];
phi = zeros(M, M);
for i = 1:M
    for j = i:M
        phi(i, j) = norm(points(i,:) - points(j,:));
    end
end

% Apply the kernel to each norm
phi = arrayfun(kernel, phi);
phi(isnan(phi)) = 0;
phi = phi + phi';

% Fit the resulting matrix into A, and make the b-vectors
rows = [X1' zeros(1, 3); Y1' zeros(1, 3); ones(1, M) zeros(1, 3)];
A = [rows; [phi Y1 X1 ones(M, 1)]];
b1 = [zeros(3,1); X2];
b2 = [zeros(3,1); Y2];

% Solve for the x vector, which gives the coefficients
x_co = linsolve(A, b1)';
y_co = linsolve(A, b2)';

end