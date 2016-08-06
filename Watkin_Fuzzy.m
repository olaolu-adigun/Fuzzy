
S = [10,20,50,100,200,500,1000,2000,5000,10000,20000,50000];
MSE = zeros(size(S));
for a = 1:1:numel(S)
    K = S(a);
    x = 0:0.01:2*pi;
    fx = sin(0:0.01:2*pi);

    Fx = zeros(size(x));

    alpha = min(fx);
    beta = max(fx);

    c1 = alpha;
    c2 = beta;

    for i = 1:1:numel(x)
    
        px_1 = (beta - sin(x(i))) / (beta - alpha);
        px_2 = (sin(x(i))-alpha) / (beta-alpha);
    
        Y = (rand(K,1)*2)- 1;
        fy = zeros(K,1);
        for j = 1:1:K
            py_x1 = normpdf(Y(j),alpha, 1);
            py_x2 = normpdf(Y(j),beta, 1);
        
            py = (px_1*py_x1) + (px_2*py_x2);
            fy(j) = Y(j)*py;
        end
    
        Fx(i) = mean(fy);
    end
    Fx = (2*Fx)/range(Fx);
    %{
    figure(a);
    
    plot(x,fx,'r');
    hold on;
    plot(x, Fx, 'b');

    xlabel('x');
    ylabel('Sin(x)');
    %}
    MSE(a) = mean((Fx-fx).^2); 
end
figure(a+1)
plot(S,MSE);