% Correlation measure calculation of Euler's number(e)
clear;  % Remove items from workspace, freeing up system memory
tic;    % start stopwatcher time


% E=[1,1,-1,-1,1,-1,-1,1,-1,-1,-1,-1,1,1,1,1,1,1,-1,1,1,-1,1,-1,...];
N = length(E);

sum_c=0;

for d1=1:(N-1)
    for d2=(d1+1):N
        M=N-d2;
         fprintf('A M=%d, d1=%d, d2=%d \n \n ',M,d1,d2);
            for n=0:M
                sum_c = sum_c + E(n+d1)*E(n+d2);
                C(n+1) = sum_c;
            end
          disp(C);
          disp(abs(C));
        z(d1,d2) = max(abs(C));
       fprintf('The maximum element is: %d \n \n',z(d1,d2));
        sum_c = 0;
        C=zeros;
    end
end
  disp(z);
  size(z);
correl_measure = max(max(z));
fprintf('the Correlation measure is: %d \n \n',correl_measure);

condition_1 = sqrt(N)*log(N); 
    fprintf('condition_1= %d \n \n',condition_1);
condition_2 = sqrt(sqrt(N^3)); 
    fprintf('condition_2= %d \n \n',condition_2);
condition_3 = (7/4)*sqrt(N*log(N)); 
    fprintf('condition_3= %d \n \n',condition_3);
    
if correl_measure < condition_1
      fprintf('The correlation measure fits with condition_1 \n \n');
else
      fprintf('The correlation measure larger than condition_1 \n \n');
end
if correl_measure < condition_2
      fprintf('The correlation measure fits with condition_2-nek \n \n');
else
      fprintf('The correlation measure larger than condition_2 \n \n');
end

if correl_measure < condition_3
      fprintf('The correlation measure fits with condition_3-nek \n \n');
else
      fprintf('The correlation measure larger than condition_3 \n \n');
end

toc