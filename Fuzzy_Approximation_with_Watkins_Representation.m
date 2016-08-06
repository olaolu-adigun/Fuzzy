%%% FUZZY APPROXIMATION WITH WATKIN'S REPRESENTATION
%% This software finds the fuzzy aproximation of sin(x)

% Define x and f(x)
x = 0:0.01:2*pi;
fx = sin(0:0.01:2*pi);

% Define Sup and inf of f(x)
alpha = min(fx);
beta = max(fx);

% Choose the size of samples for the MOnte Carlo Estimate
K = 10000;

% Define the vector that holds the Fuzzy approximation
Fx = zeros(size(x));

%% Compute the Fuzzy approximation for sin(x) 
for i = 1:1:numel(x)
    
    % Define the marginal pdfs for the two rules
    px_1 = (beta - sin(x(i))) / (beta - alpha);
    px_2 = (sin(x(i))-alpha) / (beta-alpha);
    
    % Pick K samples randomly over the range of f(x) i.e. [-1,1]
    Y = (rand(K,1)*2)- 1;
   
    fy = zeros(K,1);
    
    %% Monte Carlo Estimation
    for j = 1:1:K
        
        % Define the conditional pdf of y given x for the two rules
        py_x1 = normpdf(Y(j),alpha, 1);
        py_x2 = normpdf(Y(j),beta, 1);
        
        % Compute f(y) for all the samples of picked
        py = (px_1*py_x1) + (px_2*py_x2);
        fy(j) = Y(j)*py;
    end
    % Find the sample mean
    Fx(i) = mean(fy);
end

% Rescale the approximation F(x) back to the scale of f(x)
Fx = (2*Fx)/range(Fx);
    
% Plot the Result
figure(3);
    
plot(x,fx,'r');
hold on;
plot(x, Fx, 'k');
xlabel('x');
ylabel('Sin(x)');

% Compute the mean of squared error
mse = mean((fx-Fx).^2);
fprintf('The number of samples per Monte Carlo estimate is: %d\n', K);
fprintf('The average squared error is: %f\n', mse);