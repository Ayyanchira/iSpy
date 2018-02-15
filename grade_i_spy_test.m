% % 0.  generate "x"
% % this section will be commented out during testing
% folder_name = 'data/'; 
% setN = 3;
% objectI0 = 1; 
% objectI1 = 10;
% 
% for i = 1:setN
%     
%     % load big image
%     fn = sprintf ( '%sset%d_big_im.png', ...
%         folder_name, i );
%     b_im = imread ( fn );
%     
%     
%     % generate "x" for the big image
%     x = generate_x ( b_im );
%     
%     
%     % save "x"
%     fn = sprintf ( '%sset%d_x.mat', folder_name, i )
%     save ( fn, 'x' );
% 
% end


% 1. setup

% set info for the data to test
folder_name = 'data/';
setN = 3;
objectI0 = 1;
objectI1 = 10;
distantT = 5;

% 2. test each image
timeLimitSec = 60;      % 60 seconds for both searching and loading x
xLoadTime = 0;          % time spent loading x variable
searchTime = 0;         % time spent searching
pt = 0;                 % points

for i = 1 : setN
    % load big image
    fn = sprintf('%sset%d_big_im.png', folder_name, i);
    b_im = imread(fn);
    
    % load gt
    fn = sprintf('%sset%d_gt.csv', folder_name, i);
    gt = csvread(fn);
    
    % load "x"
    fn = sprintf('%sset%d_x.mat', folder_name, i);
    if exist(fn) ~= 0
        t = cputime;                            % start timer for loading x
        load(fn);                               % load x
        xLoadTime = xLoadTime + (cputime - t);  % update x load time
        
        if xLoadTime >= timeLimitSec
            fprintf('final points = %d\n', pt);
            return;
        end
    else
        x = '';
    end
    
    % search for object images
    for j = objectI0 : objectI1
        % load individual crop image
        fn = sprintf('%sset%d_object_im_%d.png', folder_name, i, j);
        o_im = imread(fn);
        
        % run i_spy
        t = cputime;                                % start search timer
        [r,c] = mytest1(o_im,b_im,x);               % run search
        searchTime = searchTime + (cputime - t);    % update search time
        
        % evaluate
        error_dist = pdist([gt(j,1:2);r,c], 'euclidean');
        
        if searchTime >= timeLimitSec
            fprintf('final points = %d\n', pt);
            return;
        else
            if error_dist <= distantT
                pt = pt + 1;
            end
            
            fprintf('%d,%d - alg(%d,%d) vs gt(%d,%d) - %f sec -> total pt [%d]\n',...
                i, j, r, c, gt(j,1), gt(j,2), searchTime, pt);
        end
    end
end