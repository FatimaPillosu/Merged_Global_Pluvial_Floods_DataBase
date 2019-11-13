% Create the colourmap
edges = [0,1,2,5,10,20,30,50,75,100,200];
mycolormap = zeros(256,1);
pointer1 = 1;
for i = 1 : length(edges)
    pointer2 = floor(256 * edges(i) / edges(end));
    if pointer2 == 0
        pointer2 = 1;
    elseif pointer2<pointer1
        pointer2 = pointer1;
    end
    mycolormap(pointer1:pointer2) = edges(i);
    pointer1 = pointer2 + 1;
end

MyColormap_Edges = [edges(1:end-1)', edges(2:end)'];

MyColormap_Colors = [1,1,1 %White 0-1
                     0,1,1 %Cyan 1-2
                     0,0,1 %Blue 2-5
                     0,1,0 %Green 5-10
                     1,1,0 %Yellow 10-20
                     1,0.65,0 %Orange 20-30
                     1,0,0 %Red 30-50
                     0.58,0,0.83 %Fucsia 50-75
                     0.29,0,0.51 %Purple 75-100
                     0,0,0]; %Black 100-200

MyColormap = zeros(256,3);
for i = 1 : length(MyColormap_Edges)
    if i == length(MyColormap_Edges)
        pointer = find(mycolormap>=MyColormap_Edges(i,1) & mycolormap<=MyColormap_Edges(i,2));
    else
        pointer = find(mycolormap>=MyColormap_Edges(i,1) & mycolormap<MyColormap_Edges(i,2));
    end
    colors = repmat(MyColormap_Colors(i,:),length(pointer),1);
    MyColormap(pointer,:) = colors;
end

a = [mycolormap, MyColormap];

lon2 = lon;
lat2 =lat;
precip2 = PrecipCPC(:,:,1);
figure = gcf;
set(gcf,'position',[10,10,1500,750])
h = pcolor(lon2,lat2,precip2);
set(h, 'EdgeColor', 'none');
colormap(MyColormap)
c = colorbar;
w = c.TickLabels;
c.TickLabels = {'0','1','2','5','10','20','30','50','75','100','200'};
c.Label.String = 'Rainfall [mm/24h]';
set(c, 'ylim', [edges(1) edges(end)])
set(c,'Ticks',[1 2 3 4 7 13 26 39 65 97 129])

load coast
long = long + 180;
hold on
plot(long,lat, '-k', 'LineWidth',2)