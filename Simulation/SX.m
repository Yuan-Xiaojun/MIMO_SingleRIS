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

x_opt = [3.715700e-01  3.398200e-01  2.972100e-01  2.460050e-01  1.837700e-01  1.126500e-01  6.167000e-02  2.696500e-02  8.620000e-03  1.805000e-03  1.900000e-04  ];
s_opt = [4.703101e-01  4.341860e-01  3.710078e-01  2.674419e-01  1.428682e-01  3.178295e-02  2.170543e-03  0.000000e+00  0.000000e+00  0.000000e+00  0.000000e+00  ];

x_LB = [ 3.261260e-01  2.889940e-01  2.456500e-01  1.987800e-01  1.492665e-01  1.007885e-01  5.865000e-02  2.671100e-02  8.729000e-03  1.688500e-03  1.595000e-04];
s_LB = [ 1.107907e-01  6.506977e-02  3.103101e-02  1.088372e-02  2.558140e-03  4.031008e-04  3.100775e-05  1.550388e-05  0.000000e+00  0.000000e+00  0.000000e+00  ];

x_opt_LB = [3.243700e-01  2.874000e-01  2.436800e-01  1.966650e-01  1.481750e-01  9.964000e-02  5.737500e-02  2.602500e-02  8.255000e-03  1.700000e-03  1.450000e-04  ];
s_opt_LB = [1.116279e-01  6.961240e-02  3.682171e-02  2.046512e-02  1.000000e-02  4.341085e-03  2.635659e-03  6.976744e-04  5.426357e-04  3.100775e-04  2.325581e-04  ];

%figure(1)
subplot(121)
semilogy(SNR,x,':m*','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,x_LB,':kp','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,x_opt,'-m*','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,x_opt_LB,'-kp','LineWidth',line_width,'MarkerSize',marker_size);
legend_char = { 'X','LB-{\bf{\it X}}',};
  legend(legend_char,'fontsize',11)
  xlabel('SNR (dB)','fontsize',10)
%ylabel('Normalized MSE of H','fontsize',14)
ylabel('Average BER of X','fontsize',10)
 
 subplot(122)
 semilogy(SNR,s,':m*','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,s_LB,':kp','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,s_opt,'-m*','LineWidth',line_width,'MarkerSize',marker_size);
 hold on
 semilogy(SNR,s_opt_LB,'-kp','LineWidth',line_width,'MarkerSize',marker_size);
 
 %axis([5  15  0.0000099   1]);
 % axis([0  15  0.06   1]);
 legend_char = { 'S','LB-{\bf{\it S}}',};
  legend(legend_char,'fontsize',11)
 xlabel('SNR (dB)','fontsize',10)
%ylabel('Normalized MSE of H','fontsize',14)
ylabel('Average BER of S','fontsize',10)







 