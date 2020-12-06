clc;    
clear;
close all

marker_size = 8;
line_width = 1.5;
plot_chr = {'b-','m--','k-','g-.','c--','r-.'};
plot_char2 = {'b<','m*','ko','gp','cd','r>'};

%plot(rmse_revd_time,rmse_revd,'--','Color',[0.6 0.2 0],'LineWidth',line_width,'MarkerSize',marker_size)

x=[ 0 : 1 : 15];

% N=128,K=20   p=0.3
%EM = 10;
% SNR = [-40 : 2 : -20];
% x = [ 3.724645e-01  3.429860e-01  3.066305e-01  2.642760e-01  2.120515e-01  1.509630e-01  9.088900e-02  4.248700e-02  1.436200e-02  3.859000e-03  8.025000e-04   ];
% s = [ 4.736977e-01  4.589147e-01  4.250775e-01  3.638527e-01  2.612558e-01  1.342713e-01  3.889922e-02  3.705426e-03  1.782946e-04  4.651163e-05  0.000000e+00 ];
% 
% x_LB = [ 3.261260e-01  2.889940e-01  2.456500e-01  1.987800e-01  1.492665e-01  1.007885e-01  5.865000e-02  2.671100e-02  8.729000e-03  1.688500e-03  1.595000e-04];
% s_LB = [ 1.107907e-01  6.506977e-02  3.103101e-02  1.088372e-02  2.558140e-03  4.031008e-04  3.100775e-05  1.550388e-05  0.000000e+00  0.000000e+00  0.000000e+00  ];

% EM = 20;
SNR = [-40 : 2 : -20];
x = [ 3.724385e-01  3.415290e-01  3.025175e-01  2.527945e-01  1.876005e-01  1.158310e-01  6.106700e-02  2.731000e-02  8.874000e-03  1.782500e-03  1.585000e-04 ];
s = [ 4.650388e-01  4.378450e-01  3.799845e-01  2.805349e-01  1.484264e-01  3.531783e-02  2.015504e-03  6.976744e-05  0.000000e+00  0.000000e+00  0.000000e+00 ];

x_LB = [ 3.261260e-01  2.889940e-01  2.456500e-01  1.987800e-01  1.492665e-01  1.007885e-01  5.865000e-02  2.671100e-02  8.729000e-03  1.688500e-03  1.595000e-04];
s_LB = [ 1.107907e-01  6.506977e-02  3.103101e-02  1.088372e-02  2.558140e-03  4.031008e-04  3.100775e-05  1.550388e-05  0.000000e+00  0.000000e+00  0.000000e+00  ];

XMSE = [2.974720e+01  2.728116e+01  2.413790e+01  2.018399e+01  1.493999e+01  9.230793e+00  4.869922e+00  2.180651e+00  7.089437e-01  1.420537e-01  1.266495e-02  ];


%figure(1)
% subplot(121)
 semilogy(SNR,XMSE,'-m*','LineWidth',line_width,'MarkerSize',marker_size);
%  hold on
%  semilogy(SNR,x_LB,'-kp','LineWidth',line_width,'MarkerSize',marker_size);
% legend_char = { 'X','LB-{\bf{\it X}}',};
%   legend(legend_char,'fontsize',11)
  xlabel('SNR (dB)','fontsize',10)
%ylabel('Normalized MSE of H','fontsize',14)
ylabel('Average MSE of {\bf{\it X}}','fontsize',10)
 
%  subplot(122)
%  semilogy(SNR,s,'-m*','LineWidth',line_width,'MarkerSize',marker_size);
%  hold on
%  semilogy(SNR,s_LB,'-kp','LineWidth',line_width,'MarkerSize',marker_size);
%  
%  %axis([5  15  0.0000099   1]);
%  % axis([0  15  0.06   1]);
%  legend_char = { 'S','LB-{\bf{\it S}}',};
%   legend(legend_char,'fontsize',11)
%  xlabel('SNR (dB)','fontsize',10)
% %ylabel('Normalized MSE of H','fontsize',14)
% ylabel('Average BER of S','fontsize',10)




 