function [x] = generate_x ( b_im )

grayImage = int32(rgb2gray(b_im));
bigSize = size(grayImage);
brow = bigSize(1);
bcol = bigSize(2);
x(256) = struct('rowVal',[],'colVal',[]);
tic;
    for row = (1:brow)
        for col = (1:bcol)
        %intensity is increased by one as index starts from 1
        intensity = grayImage(row,col)+1;
        x(intensity).rowVal = [x(intensity).rowVal,row];
        x(intensity).colVal = [x(intensity).colVal,col];
        end
    end
    
    return;
end

% sizeImage = size(b_im);
% grayImage = rgb2gray(b_im);
% 
% nothing useful for now
% x.table = [1 2 3];
% x.magic = [25.5 2.1];