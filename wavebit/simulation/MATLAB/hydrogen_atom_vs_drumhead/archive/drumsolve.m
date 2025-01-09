% Christopher Mitchell EE 2009
% Circular Membrane Mode Solver/Simulator v1.1

function [] = drumsolve(n,m)

figure(1);

gran_rad=0.1;
gran_theta=(2*pi)/360;
changetol = 0.001;

radmax = 5;
zmax = 1;

rad=[0:gran_rad:radmax];
theta=[0:gran_theta:2*pi];

%generate the polar mesh
for a=1:length(rad)
    x(:,a)=rad(a)*cos(theta);
    y(:,a)=rad(a)*sin(theta);
    movable(1:length(theta),a)=1;
end

%set up immovable radii
if (n>0)
    for a=1:n
        myangle=(a-1)*(pi./n);
        movable(1+round(myangle./gran_theta),:)=0;
        z(1+round(myangle./gran_theta),:)=0;
        movable(1+round((pi+myangle)./gran_theta),:)=0;
        z(1+round((pi+myangle)./gran_theta),:)=0;
    end
end

% set up immovable concentric circles
if (m>0)
    for a=1:m-1
        myrad=radmax-(a-1)*(radmax/(m-1));
        movable(:,1+round(myrad./gran_rad))=0;
        z(:,1+round(myrad./gran_rad))=0;
    end
end

%set up initial z values to smooth
rowstart = 1;

for b=2:length(rad)-1
    if (m==0 || movable(2,b)==1)
        blockstart = rowstart;
        for a=1:length(theta)
            if movable(a,b)==1
                z(a,b)=blockstart;
            else
                blockstart=blockstart*-1;
            end
        end
    else
        rowstart = rowstart*-1;
    end
end

%smooth it out using the numerical Laplacian method, modified for polar
%coordinates, or if you prefer, the polar-modified numerical Laplacian
done=0;
iter=0;
while done==0

%    disp(sprintf('min max %f %f',min(min(z)),max(max(z))));

    done=1;
    for b=1:length(rad)
        for a=1:length(theta)
            if (movable(a,b) == 1)
                div = 1;
                neighbortotal = 0;
                if (b ~= 1)
                    rscale = sin((pi-gran_theta)/2)./((b-1).*sin(gran_theta));
                    div = div + 2.*rscale;
                    if (a==1)
                        neighbortotal = rscale.*z(length(theta),b);
                    else
                        neighbortotal = rscale.*z(a-1,b);
                    end
                    if (a==length(theta))
                        neighbortotal = neighbortotal + rscale.*z(1,b);
                    else
                        neighbortotal = neighbortotal + rscale.*z(a+1,b);
                    end
                end
                if (b > 1)
                    neighbortotal = neighbortotal + z(a,b-1);
                else
                    neighbortotal = neighbortotal + z(mod((a+round(pi./gran_theta)-1),length(theta))+1,2);
                end
                if (b<length(rad))
                    neighbortotal = neighbortotal + z(a,b+1);
                    div = div + 1;
                end
                new = neighbortotal./div;
                if abs(new-z(a,b))>changetol
                    done = 0;
                end
                z(a,b)=new;
            end
        end
    end
iter = iter+1;

end

disp(sprintf('Converged in %.0f iterations.',iter));
z=z.*zmax./max(max(abs(z)));
disp(sprintf('min %f max %f',min(min(z)),max(max(z))));

for i=1:5;
    for rho=0:pi./12:2*pi;
        coeff = sin(rho);
        clf;
        mesh(x,y,coeff.*z);
        axis([-radmax radmax -radmax radmax -2*zmax 2*zmax -1*zmax zmax]);
        M(1)=getframe();
    end
end