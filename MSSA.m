function [RC,LAMBDA] = MSSA(X,M,I)
[N,n_c] = size(X);
y= zeros(N-M+1,M);

%% building the trajectory matrix
for i = 1:n_c
    for m = 1:M
        y(:,m) = X((1:N-M+1)+m-1,i);         
    end
        
    if i ==1
        Y =y ;
%         disp(size(Y));
        continue;
    end
    Y = [Y,y]; 
%     disp(size(Y));
end

%% SVD
Cemb=Y'*Y / (N-M+1);

[RHO,LAMBDA] = eig(Cemb);
LAMBDA = diag(LAMBDA);      % extract the diagonal

[LAMBDA,ind]=sort(LAMBDA,'descend'); % sort eigenvalues
RHO = RHO(:,ind);             % and eigenvectors


%% GROUPING
PC = Y*RHO;
% disp(PC)
RC = zeros(N,I,n_c);

for c = 1:n_c
    for m = 1:I
    
        buf = PC(:,m)*RHO( (c-1)*M +1:c*M ,m)';
        buf = buf(end:-1:1,:); %invert projection

        for n = 1:N
            RC(n,m,c) = mean( diag(buf,-(N-M+1)+n) );
            
        end
       
    end
   
end
end