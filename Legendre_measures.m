clear;
p=30011;
ls=qrseq(p);
% disp(ls);
N=length(ls);
tic;
sum_w=0;

for a=1:15005
    for b=1:15005        
        t=floor((N-a)/b);
        fprintf('A t=%d, a=%d, b=%d \n \n ',t,a,b);
            for j=0:t
                sum_w = sum_w + ls(a+b*j);
                W(j+1) = sum_w;
            end
        % disp(W);
        % disp(abs(W));
        z(a,b) = max(abs(W));
        fprintf('The maximum element is: %d \n \n',z(a,b));
        sum_w = 0;
        W=zeros;
    end
end
% disp(z);
% size(z);
well_distrib_measure = max(max(z));
fprintf('Well-distribution measure is: %d \n \n',well_distrib_measure);
feltetel_1 = sqrt(N)*log(N);
feltetel_2 = sqrt(sqrt(N^3));
if well_distrib_measure < feltetel_1
      fprintf('The well-distribution measure fits with condition_1 \n \n');
else  fprintf('The well-distribution measure larger than condition_1 \n \n');
end

if well_distrib_measure < feltetel_2
      fprintf('The well-distribution measure fits with condition_2 \n \n');
else  fprintf('The well-distribution measure larger than condition_2 \n \n');
end
toc
