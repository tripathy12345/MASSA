function modes = mssa_decomp(x, L, nc, epsilon, force_supk)
% function modes = ssa_decomp(x, L, nc, epsilon, force_supk)
%
% SSA with hierarchical clustering  for components grouping
% In the hierarchical clustering, the last components whose energy contribution is relatively
% null are eliminated from the clustering procedure. epsilon serves as threshold. 
%
% Input:
% x: input signal
% L: SSA window length
% nc: vector containing number of components to extract per channel
% epsilon: threshold applied on the values in the singular spectrum (default: 3e-2)
% force_supk: constraint the number of singular values to use (default: supk depends on epsilon)

% Output:
% num_channels * length * num_components

if ~exist('epsilon', 'var')
 epsilon = 0.003; %0.5; %
end

if ~exist('force_supk', 'var')
 force_supk = inf;    
end

Nx=length(x);

% If number of channels is less than one, return
if nc < 1
 return;
end

% Get eigenvalues using ssa
[~,d]=MSSA(x,L,1);

% Remove negligible components to improve clustering
supk = length(find((d/max(d))>epsilon));

% If supk is less than any nc, choose supk as max of nc 
for i = 1:length(nc)
 if supk <  nc(i)
%     warning('epsilon is too high, trying with eps=%.2f', d(nc)/max(d))
    supk = max(nc);
 end
end

if force_supk < inf
 supk = force_supk;
end

% Get RCs for all channels
[y,~]=MSSA(x,L,supk);

% Calculating correlation matricex for each channel
wcorr = zeros(supk, supk, length(nc));
for i=1:length(nc)
    wcorr(:,:,i) = wCorrMat(x, L, supk, y(:,:,i));
end

modes = zeros(length(x), max(nc), length(nc));

for i = 1:length(nc)
    modes(:,1:nc(i), i) = hca(x, y(:,:,i), wcorr(:,:,i), nc(i));    
end

end