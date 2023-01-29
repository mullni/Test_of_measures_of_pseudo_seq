clear;  % Remove items from workspace, freeing up system memory
tic;    % start stopwatcher time

% 12500 digits for e
E=[1,-1,1,-1,1,1,-1,1,1,1,1,1,1,-1,-1,-1,-1,1,...];
N = length(E);
sum_w=0;

for a=1:6250
    for b=1:6249
        t=floor((N-a)/b);
        fprintf('A t=%d, a=%d, b=%d \n \n ',t,a,b);
            for j=0:t
                sum_w = sum_w + E(a+b*j);
                W(j+1) = sum_w;
            end
        z(a,b) = max(abs(W));
        fprintf('The maximum element is: %d \n \n',z(a,b));
        sum_w = 0;
        W=zeros;
    end
end

well_distrib_measure = max(max(z));
fprintf('Well distribution measure is: %d \n \n',well_distrib_measure);
condition_1 = sqrt(N)*log(N);
condition_2 = sqrt(sqrt(N^3));
if well_distrib_measure < condition_1
      fprintf('Well distribution measure fits with condition_1 \n \n');
else
      fprintf('Well distribution measure larger than condition_1 \n \n');
end
if well_distrib_measure < condition_2
      fprintf('Well distribution measure fits with condition_2 \n \n');
else
      fprintf('Well distribution measure larger than condition_2 \n \n');
end
toc