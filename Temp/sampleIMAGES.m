function patches = sampleIMAGES()
% sampleIMAGES
% Returns 10000 patches for training

load('IMAGES.mat', 'IMAGES');

patchsize = 8;  % we'll use 8x8 patches 
numpatches = 10000;

% Initialize patches with zeros.  Your code will fill in this matrix--one
% column per patch, 10000 columns. 
patches = zeros(patchsize*patchsize, numpatches);

counter = 1;
ranimg = ceil(rand(1, numpatches) * 10);
ranpix = ceil(rand(2, numpatches) * (512 - patchsize));
ranpixm = ranpix + patchsize - 1;
while(counter <= numpatches)
whichimg = ranimg(1, counter);
whichpix = ranpix(:, counter);
whichpixm = ranpixm(:, counter);
patch = IMAGES(whichpix(1):whichpixm(1), whichpix(2):whichpixm(2), whichimg);
repatch = reshape(patch, patchsize * patchsize, 1);
patches(:, counter) = repatch;
counter = counter + 1;
end

function patches = normalizeData(patches)
 
% Squash data to [0.1, 0.9] since we use sigmoid as the activation
% function in the output layer
 
% Remove DC (mean of images). 
patches = bsxfun(@minus, patches, mean(patches));
% Truncate to +/-3 standard deviations and scale to -1 to 1
pstd = 3 * std(patches(:));
patches = max(min(patches, pstd), -pstd) / pstd;
% Rescale from [-1,1] to [0.1,0.9]
patches = (patches + 1) * 0.4 + 0.1;
 
end



%% ---------------------------------------------------------------
% For the autoencoder to work well we need to normalize the data
% Specifically, since the output of the network is bounded between [0,1]
% (due to the sigmoid activation function), we have to make sure 
% the range of pixel values is also bounded between [0,1]
patches = normalizeData(patches);

end


%% ---------------------------------------------------------------
function patches = normalizeData(patches)

% Squash data to [0.1, 0.9] since we use sigmoid as the activation
% function in the output layer

% Remove DC (mean of images). 
patches = bsxfun(@minus, patches, mean(patches));

% Truncate to +/-3 standard deviations and scale to -1 to 1
pstd = 3 * std(patches(:));
patches = max(min(patches, pstd), -pstd) / pstd;

% Rescale from [-1,1] to [0.1,0.9]
patches = (patches + 1) * 0.4 + 0.1;

end
