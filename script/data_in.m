% Read the image
img = imread('desert.jpg');   % or .jpg, .png, etc.

% Convert to BGR (since your Verilog seems to need it as BGR)
imgBGR = img(:, :, [3 2 1]);

% Image size
[h, w, ~] = size(imgBGR);
block_size = 8;  % 8x8 pixels per block

% Open a file to save Verilog-style statements
fid = fopen('pixel_data.txt', 'w');

% Total number of pixels
total_pixels = h * w;
pixel_count = 0;

% Go through blocks
for by = 1:block_size:h
    for bx = 1:block_size:w
        % Extract one 8x8 block
        block = imgBGR(by:by+block_size-1, bx:bx+block_size-1, :);

        % Flatten block in row-major order (left→right, top→down inside block)
        pixels = reshape(permute(block, [2 1 3]), [], 3);

        % If this is the very last block → assert EOF signal once
        if pixel_count == total_pixels - 64
            fprintf(fid, 'end_of_file_signal  <= 1''b1;\n');
        end

        % Loop through 64 pixels of this block
        for k = 1:size(pixels,1)
            pixel_count = pixel_count + 1;

            B = pixels(k,1);
            G = pixels(k,2);
            R = pixels(k,3);

            % Convert each channel to 8-bit binary
            Rbin = dec2bin(R, 8);
            Gbin = dec2bin(G, 8);
            Bbin = dec2bin(B, 8);

            % Choose format (BGR)
            binStr = [Bbin Gbin Rbin];   % BGR order

            % Write pixel to file
            fprintf(fid, '\tdata_in <= 24''b%s;\n#10000;\n', binStr);
        end

        % Only add block-separator if NOT the last block
        if pixel_count < total_pixels
            fprintf(fid, '#130000;\n');
            fprintf(fid, 'enable <= 1''b0;\n');
            fprintf(fid, '#10000;\n');
            fprintf(fid, 'enable <= 1''b1;\n');
        end
    end
end

% At the extreme end, only these three lines
fprintf(fid, '#130000;\n');
fprintf(fid, 'enable <= 1''b0;\n');

fclose(fid);
disp('✅ Pixel data written to pixel_data.txt (EOF only before last block, clean end)');
