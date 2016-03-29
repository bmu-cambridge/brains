%% short wrapper function for BrainNet Visualization
%% INPUT
% nodes - cell structure that contains 6 columns in the following order: nodex, nodey, nodez, nodesize, nodecolour, nodename
% nameN - string with the name of your desired nodefile output (e.g. 'mynodes.node')
% edges - standard 2D symmetric matrix with your connections (binary or weighted undirected)
% nameE - string with the name of your desired edgefile output ((e.g. 'myedges.edge')


function [] = writeNodes(nodes, nameN, edges, nameE)

fileID = fopen(nameN,'w');

formatSpec = '%d %d %d %d %d %s\n';
del = 't';

[nrows,ncols] = size(nodes);
for row = 1:nrows
    fprintf(fileID,formatSpec,nodes{row,:});
end

fclose(fileID);

dlmwrite(nameE,edges,'delimiter','\t');

end
