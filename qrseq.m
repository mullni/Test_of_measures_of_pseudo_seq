function ls = qrseq(p)
% p = 7; ls = qrseq(p); disp(ls);

if p<3 || ~isprime(p) 
    error('qrseq:primality', 'p must be an odd prime.');
end
if eps((p/2)^2) > 1
    error('qrseq:toobig', 'p is too large.');
end
ls = [0 -ones(1,p-1)];
ls(1+mod((1:(p-1)/2).^2,p)) = 1;
end

