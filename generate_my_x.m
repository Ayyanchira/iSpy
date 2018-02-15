
grayImage = int32(rgb2gray(imread('big.png')));
bigSize = size(grayImage);
brow = bigSize(1);
bcol = bigSize(2);
totalpixels = brow*bcol;
p(256) = struct('x',[],'y',[]);
for row = (1:brow)
    for col = (1:bcol)
        %intensity is increased by one as index starts from 1
        intensity = grayImage(row,col)+1;
        p(intensity).x = [p(intensity).x,row];
        p(intensity).y = [p(intensity).y,col];
    end
end