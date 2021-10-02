%% This is a shell that you will have to follow strictly. 
% You will use the plotmap() and viewmap() to display the outcome of your algorithm.

% Load sample_data_map_8, three variables will be created in your workspace. These were created as a 
% result of [m,v,s]=dfs('map_8.txt',[14,1],[1,18]);
% The solution can be viewed using 
% plotmap(m,s) 

% write your own function for the DFS algorithm.
function [retmap,retvisited,retsteps] = bfs(mapfile,startlocation,targetlocation)
    %retmap = is the map file returned as a matrix
    %retvisited = is a matrix that shows which cells have been visited, '0' means
    %visited, '1' means not visited
    %retsteps = is the vector of steps to reach the target
    
    startid = arr2id(startlocation);
    targetid = arr2id(targetlocation);
    map = map_convert(mapfile); %generate map matrix
    map_size = size(map);
      
    q = Queue;
    q.push(startid);
    visited = containers.Map; %create key value pair
    visited(startid) = NaN; 
    
    rowNum = [-1,0,0,1];
    colNum = [0,-1,1,0];
    
    while ~q.empty() %until q is empty
        currentid = q.front();
        current = id2arr(currentid);
        q.pop(); %pop current item (first item) in the queue
        
        for i=1:4 %up down left right from current point
            next = [current(1) + colNum(i), current(2) + rowNum(i)];
            if next(1) > 0 && next(1) <= map_size(1) && next(2) > 0 && next(2) <= map_size(2) %make sure the next point is within the map
                if eq(map(next(1), next(2)),0) %if movable to that point
                    nextid = arr2id(next);
                    currentid = arr2id(current);
                    if ~visited.isKey(nextid) %if nextid is not in the keys visited
                        visited(nextid) = currentid; %set visited(key) = value
                        if strcmp(nextid, targetid) %true if next == target
                            break %exit the loop
                        end
                        q.push(nextid);
                    end
                end
            end
        end
    end
    
    shortest_path = [];
    while(~isnan(targetid)) %while targetid is not NaN 
        shortest_path(end + 1, :) = id2arr(targetid);
        targetid = visited(targetid);
    end
    
    retsteps = flipud(shortest_path); %flip array to get shortest path
    retmap = map; 
    keySet = visited.keys();
    retvisited = ones(map_size(1), map_size(2)); 
    
    for i = 1:length(keySet)
        visited_pos = id2arr(keySet{i}); 
        retvisited(visited_pos(1), visited_pos(2)) = 0; %if i have visited, set to 0
    end
end

function arr = id2arr(id)
    split_id = strsplit(id, '.');
    arr = [str2double(split_id(1)), str2double(split_id(2))];
end

function id = arr2id(arr)
    id = [int2str(arr(1)) '.' int2str(arr(2))];
end

function placestep(position,i)
% This function will plot a insert yellow rectangle and also print a number in this rectangle. Use with plotmap/viewmap. 
position = [16-position(1) position(2)];
position=[position(2)+0.1 position(1)+0.1];
rectangle('Position',[position,0.8,0.8],'FaceColor','y');
c=sprintf('%d',i);
text(position(1)+0.2,position(2)+0.2,c,'FontSize',10);
end
