function [names, outFile, mask] = rb_checkErrors(directory, nodes)
%% Function to run the first step in resting-state graph theory: determine the number of zero parcels and create a mask

%% Input
% directory     -   directory where all your error.txt files are stored
%                   these assume your error.txt files were obtained with
%                   parcellate.sh
% nodes         -   predtermined number of nodes based on your parcellation
%                   scheme

%% Output
% names         -   list of file/subject names
% outFile       -   matrix containing subjects*nodes errors
% mask          -   maskfile to be used in 2nd level processing to mask out
%                   empty time-courses across all subjects

%get all txt files
files = dir(fullfile(directory,'*_error.txt'));
names = {};
%nodes = 471;
outFile = zeros(numel(files),nodes);
% loop trough files
for ifile = 1:numel(files)

    % get the subject name minus the suffix
    name=files(ifile).name;
    posBar = strfind(name,'_');
    names{ifile,1} = name(1:posBar-1);
    
    % load the error file and put in masl
    mask = load(name);
    errors = zeros(1,nodes);
    errors(mask) = 1;
    
    outFile(ifile,:) = errors;
    
end

mask = mean(outFile);
mask(mask>0) = 1;

figure; 
subplot(2,1,1);imagesc(outFile);colormap(flipud(gray));
ax = gca;
 title(['Missing parcels per subject ']); xlabel('node'); ylabel('Subjects'); ax.YTick = 0:1:numel(names); ax.YTickLabel = names;
 set(gca, 'ygrid', 'on','ycolor', 'k');

ErrorPerc =  (sum(mask)/nodes)*100;
subplot(2,1,2);imagesc(mask);colormap(flipud(gray));
bx = gca;
 title(['Total error percentage = ' sprintf('%.2f', ErrorPerc) '% of nodes']);bx.YTick = [0 1];
 set(gca, 'ygrid', 'on','ycolor', 'k');

 mask = logical(mask);
 mask = ~mask; %invert because it makes it easier to use later on
 save('mask.mat','mask');
 
 h = gcf;
 saveas(h,[directory '/Missing_Parcels'],'fig');
 saveas(h,[directory '/Missing_Parcels'],'tif');
 
end


