%run this file to simulate
% Your simulations will use this structure
% O(N) n = num of nodes
[m,v,s]=bfs('map1.txt',[4,2],[11,18]);
%Here   'm' is the map file returned as a matrix
%       'v' is a matrix that shows which cells have been visited, '0' means
%       visited, '1' means not visited
%       's' is the vector of steps to reach the target,

%To view the path determined above use 
plotmap(m,s);



