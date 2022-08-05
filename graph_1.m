function graph(x1,x2,y,b)

scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):100:max(x1);
x2fit = min(x2):10:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT ;
colormap summer
mesh(X1FIT,X2FIT,YFIT)
xlabel('Xinp')
ylabel('Yinp')
zlabel('Output')
view(50,10)
hold off

end