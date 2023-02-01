clc
clear all
dbstop if error
%Topologically robust sound propagation in an angular-momentum-biase graphene-like resonator lattic
% Acoustic Zeeman effect; Coupled mode theory; S matrix; Acoustic resonant cavity; Bluk band structure; Topological edge states
%% Parameter: cavity and velocity
C0=359;                                                          %Sound velocity 
R_in=5.08*10^-2;                                              % Geo para
R_out=9.21*10^-2;
R_av=(R_in+R_out)/2;
W0=C0/R_av;                                                    % Eigen angle freq for Original Carvity
f0=W0/(2*pi);
length0=1*10^-2;
Delta_freq=20;                                                  % Resonance Bandwidth
Decay_t=2/(2*pi*Delta_freq);
Gama=1/Decay_t;                                             % Inverse of decay time 
Gama_p=Gama;
Gama_m=Gama;
Q=W0/(2*Gama);
V=C0/(2*Q*sqrt(3));                                                                %Additional velocity % V=C0/(2*Q*sqrt(3));  
Delta_W=V/R_av;                                              % Acoustic Zeeman effect
W_p=W0+Delta_W; W_m=W0-Delta_W; 

%% Matrix: Basic S para (coupled model theory)
L2=1500;                          
f=linspace(f0-5*Delta_freq,f0+5*Delta_freq,L2);
w=2*pi*f;
A_p=1i*sqrt(2*Gama_p/3)./(w-W_p+1i*Gama_p); A_m=1i*sqrt(2*Gama_m/3)./(w-W_m+1i*Gama_m);
A_p_E=sqrt(2*Gama_p/3)*A_p; A_m_E=sqrt(2*Gama_m/3)*A_m;
S11=exp(1i*2*length0*w/C0).*(-1+A_p_E+A_m_E);
S21=exp(1i*2*length0*w/C0).*(exp(1i*2*pi/3)*A_p_E+exp(-1i*2*pi/3)*A_m_E);
S31=exp(1i*2*length0*w/C0).*(exp(1i*4*pi/3)*A_p_E+exp(-1i*4*pi/3)*A_m_E);

figure (1)
plot(f, abs(S11),'b',f, abs(S21),'r',f, abs(S31),'m')
legend('S11','S21','S31')
xlabel('Freq f (Hz)')
ylabel('S-para abs')
V_show=['V =', num2str(round(V*10^2)/(10^2)),' m/s'];
title({ V_show})

%% Lattice network (Bulk band structure and Matrix theory of conditional number)
%parameter: lattic
a=100*10^-2;                                                      %lattic size (small)
L1=500;                                                              % dimension of cycle 
CN=zeros(L1,L2);                                               %matrix condition number
kx_linear=linspace(0,4*pi/(sqrt(3)*a),L1);
N_lattice=2;
N_port=3*N_lattice;
for i=1:L1                                                           % wavenumber cycle
    kx=kx_linear(i);                                              % reciproal space, wavenumber
    ky=0;
         for j=1:L2
              %f(j) S11(j) S21(j) S31(j) for single circulator
              % Matrix Formation of sigma minus B
              
              S=zeros(3,3);
              S(1,1)=S11(j);S(2,2)=S(1,1);S(3,3)=S(1,1);
              S(2,1)=S21(j);S(1,3)=S(2,1);S(3,2)=S(2,1);
              S(3,1)=S31(j);S(1,2)=S(3,1);S(2,3)=S(3,1);
             
              S_all=kron(eye(N_lattice),S);
              % row and column exchange
              S_all([3;5],:)=S_all([5;3],:);
              S_all([4;6],:)=S_all([6;4],:);
              S_all(:,[3;5])=S_all(:,[5;3]);
              S_all(:,[4;6])=S_all(:,[6;4]);
              
              B=zeros(N_port,N_port);
              PBC_m=exp(-1i*a/2*(kx+sqrt(3)*ky));
              PBC_p=exp(1i*a/2*(kx+sqrt(3)*ky));
              PBC_y_m=exp(-1i*a*kx);
              PBC_y_p=exp(1i*a*kx);
              B(1,3)=PBC_y_m;
              B(2,4)=PBC_m;
              B(3,1)=PBC_y_p;
              B(4,2)=PBC_p;
              B(5,6)=1;
              B(6,5)=1;

              A_total=S_all-B;
              CN(i,j)=20*log10(cond(A_total,2));
         end
end
CN=CN.';

figure(2)
[kx_m,f_m]=meshgrid(kx_linear,f);
mesh(kx_m,f_m,CN)
xlabel('Wavenumber K')
ylabel('Freq f (Hz)')
title({ V_show})
%% search the band structure to obtain the wave propagation in network
M=4;                                                                %Number of band counting
M_real=10;
kx_band=ones(M,1)*kx_linear;
f_band=zeros(M,L1);
CN_band=zeros(M,L1);
Index_band=zeros(M,L1);
f_band_re=zeros(M,1);
%search process
for i=1:L1
    Temp_CN=CN(:,i);
    k_c=1;                                                            % counting the number of peak of Condition number matrix for each wave number
    f_band_temp=zeros(1,M_real);
    CN_band_temp=zeros(1,M_real);
    Index_temp=zeros(1,M_real);
     for j=2:L2-1
         if (Temp_CN(j)>Temp_CN(j-1))&&(Temp_CN(j)>Temp_CN(j+1))
             f_band_temp(k_c)=f(j);
             CN_band_temp(k_c)=CN(j,i);
             Index_temp(k_c)=j;
             k_c=k_c+1;
         end
     end
    [CN_non,Loc]=sort(CN_band_temp);
    M_temp=min(k_c-1,M);
    Loc_temp=Loc(M_real-M_temp+1:M_real);
    M_diff=M-M_temp;
    for i_temp=1:M_temp
         Index_selected=Index_temp(Loc_temp(i_temp));
         f_band_re(i_temp)=f(Index_selected);
        CN_band(i_temp,i)=CN(Index_selected,i);
    end
   f_band(:,i)=sort(f_band_re);
end
% if giving a defined K point to calculate the allowed frequency
K=0.596118428325475; %4*pi/(3*a)
Temp_kx_diff=abs(K-kx_linear);
Index_kx=find(Temp_kx_diff==min(Temp_kx_diff));
Temp_CN=CN(:,Index_kx);
figure(3)
plot(f,Temp_CN)
% plot selected band structure
figure(4)
plot(kx_linear,f_band(1,:),kx_linear,f_band(2,:),kx_linear,f_band(3,:),kx_linear,f_band(4,:))
xlabel('Wavenumber K')
ylabel('Freq f (Hz)')
axis([min(kx_linear) max(kx_linear) min(f) max(f)])
title({ V_show})







