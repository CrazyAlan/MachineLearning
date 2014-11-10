function [data_train] = loadData()

    clear all;
    
    %Find the size of each image 
    fid = fopen('iccv09Data/horizons.txt');
    img_size = textscan(fid, '%s %f %f %f');
    fclose(fid);
    
    %Get all the image data
    img_info = dir(sprintf('iccv09Data/images/*.jpg'));

    data_train = struct('rgbimage',[],'grayimage',[],'region',[]);
    
    i = 1;
    for img_ind = 1:length(img_info)
        
        filename = strtok(img_info(img_ind).name, '.');
        if (strcmp(img_size{1}(img_ind), filename))
            N = img_size{2}(img_ind);
            M = img_size{3}(img_ind);
        else
            fprintf('Error: %s mismatch with %s in horizons.txt\n',filename, img_info(img_ind).name);
        end
        
              
        if (exist(sprintf('iccv09Data/labels/%s.regions.txt', filename), 'file'))
            
            data_train(i).region = reshape(textread(sprintf('iccv09Data/labels/%s.regions.txt', filename)),M,N);
            
            %Check if the image has foreground object, 
            %label 7 means the pixel is foreground
            if(max(data_train(i).region(:)) < 7)
                fprintf('There is no foreground image in %s\n', filename);
            else
                 %Each imread return MxNx3, where 3 are red, green and blue channel 
                 
                data_train(i).rgbimage = imread(sprintf('iccv09Data/images/%s',img_info(img_ind).name));
                data_train(i).intensity = rgb2gray(data_train(i).rgbimage);
                i = i+1;
            end
        else
            fprintf('Error: %s does not have label file available\n',filename);
        end
               
    end
end
