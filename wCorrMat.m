function wCorr = wCorrMat(x,L,supk,Y)

N=length(x);
w=zeros(N,1);
wCorr=zeros(supk,supk);

for i=1:N
 w(i)=min([i L N-i+1]);
end

for i =1:supk
  for j= 1 : supk
    wCorr(i,j)=  sum(w.*Y(:,i).*Y(:,j))/(sqrt(sum(w.*Y(:,i).^2)*sum(w.*Y(:,j).^2)));
  end
end

end
