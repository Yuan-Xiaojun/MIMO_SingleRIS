# Passive Beamforming and Information Transfer Design for Reconfigurable Intelligent Surfaces Aided Multiuser MIMO Systems

This package contains the official implementation of the **SAA-based P-BF algorithm** and the **simplified P-BF algorithm** for RIS design, and the  **turbo message passing (TMP) algorithm** for receiver design in PBIT Mu-MIMO systems proposed in the paper 

> W. Yan, X. Yuan, Z. -Q. He and X. Kuai, "Passive Beamforming and Information Transfer Design for Reconfigurable Intelligent Surfaces Aided Multiuser MIMO Systems," in IEEE Journal on Selected Areas in Communications, vol. 38, no. 8, pp. 1793-1808, Aug. 2020, doi: [10.1109/JSAC.2020.3000811] (https://ieeexplore.ieee.org/document/9117136).

## Introduction

*Sample average approximation* (SAA) based iterative algorithm is an effective way to solve the objective function (7)  (i.e., maximize the achievable rate of users in  Mu-MIMO PBIT systems) in the paper.  The algorithm handles the expectation of RIS data ***s*** in the objective function by independently generating a number of replications of ***s*** based on its probability model. Due to the larger number of samples in each batch to guarantee the performance of SAA, the convergence speed of the algorithm is very slow.    *Simplified P-BF algorithm* is an efficient alternative algorithm to maximize the achievable rate in the Mu-MIMO PBIT systems  by approximating the stochastic program in (8) as a deterministic alternating optimization problem in (26). The *turbo message passing (TMP) algorithm* contains two modules, one for the estimation of the user signals and the other for the estimation of the on-off state of each RIS element. Each module is solved by the existing GGAMP-SBL algorithm proposed in the paper

>M. Al-Shoukairi, P. Schniter and B. D. Rao, "A GAMP-Based Low Complexity Sparse Bayesian Learning Algorithm," in IEEE Transactions on Signal Processing, vol. 66, no. 2, pp. 294-308, 15 Jan.15, 2018, doi: [10.1109/TSP.2017.2764855] (https://ieeexplore.ieee.org/document/8074806).



## Code Structure

`main.m`: Set system parameters and output simulation results. 

`MIMO_algorithm`: Generate system model.

`CVX_Optimal_SAA`  and `CVX_Optimal_Simplify`: Optimize RIS phase shifts.

`SBL_GAMP_X` and `SBL_GAMP_S`: SBL_GAMP algorithm for the estimation of user signals and RIS data respectively.

`MIMO_result.txt`: Save the simulation results. 

## Citation
```
@article{yan2020passive,
  title={Passive beamforming and information transfer design for reconfigurable intelligent surfaces aided multiuser MIMO systems},
  author={Yan, Wenjing and Yuan, Xiaojun and He, Zhen-Qing and Kuai, Xiaoyan},
  journal={IEEE Journal on Selected Areas in Communications},
  volume={38},
  number={8},
  pages={1793--1808},
  month={Aug.},
  year={2020},
  publisher={IEEE}
}
```


