clc;
clear all;
close all;
load data_mul.mat;
X=data_mul';
X=X((1:256),:);
embed_dim=50;
comp=5;
%%%%%%%%%MSSA
[RC,LAMBDA] = MSSA(X,embed_dim,comp);
output=RC;
figure
ch1modes=RC(:,:,1);
subplot(5,1,1)
plot(ch1modes(:,1))
subplot(5,1,2)
plot(ch1modes(:,2))
subplot(5,1,3)
plot(ch1modes(:,3))
subplot(5,1,4)
plot(ch1modes(:,4))
subplot(5,1,5)
plot(ch1modes(:,5))
%%%%%%MASSA%%%%%%%%%%%%
cc=comp*ones(1,32);
tol=0.001;
RCM = mssa_decomp(X, embed_dim, cc, tol);
figure
ch1modes=RCM(:,:,1);
subplot(5,1,1)
plot(ch1modes(:,1))
subplot(5,1,2)
plot(ch1modes(:,2))
subplot(5,1,3)
plot(ch1modes(:,3))
subplot(5,1,4)
plot(ch1modes(:,4))
subplot(5,1,5)
plot(ch1modes(:,5))
