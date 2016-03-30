%% Function to prepare your data for running permutation test across a 2D matrix
%% Trim off upper half of the R correlation matrix and put into vector
function [Input1, Input2, Maskidx, Mask] = rb_2DGetPermInput(Data, ControlIndices, CaseIndices)

%% Input
% Data              - 3D matrix with subjects*nodes*nodes
% ControlIndices    - Index for group 1 (e.g. 1:20)
% CaseIndices       - Index for group 2 (e.g. 21:40)

%Data = abs(Data);

for isub = 1:size(Data,1)
    SubMat = squeeze(Data(isub,:,:));
    Mask = tril(SubMat,-1);  Mask = Mask~=0;
    LowerTriangleMat(isub,:) = SubMat(Mask); 
end % for isub

%% Allocate indices for the trimmed matrices
Maskidx = find(Mask>0);
[x, y]= ind2sub(size(Mask),Maskidx);

%% Get the trimmed of matrices for each group seperately
Input1 = LowerTriangleMat(ControlIndices,:);
Input2 = LowerTriangleMat(CaseIndices,:);
