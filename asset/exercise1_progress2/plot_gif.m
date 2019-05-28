
filename = 'phase_evol.gif'; % Specify the output file name
for k = 1:9
    img = imread(['echo-' num2str(k) '.png']);
    [A,map] = rgb2ind(img,256);
    if k == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.5);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
    end
end