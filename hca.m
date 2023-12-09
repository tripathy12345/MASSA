function modes = hca(x, y, wcorr, nc)

Nx = length(x);

if ~isempty(wcorr)
 Z = linkage(wcorr);                       
 T = cluster(Z,'maxclust', nc); 
 
 modes = zeros(Nx, nc);
 for i = 1:nc       
  idx = find(T == i);

  if length(idx) > 1
   modes(:, i) = sum(y(:, idx).');
   
  else
   modes(:, i) = y(:, idx).';
  end
 end
end

end