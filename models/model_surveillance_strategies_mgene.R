stan_program <- write_stan_file(
  "data {
  // Population sizes and number of tests per population
  int<lower=1> N1; int<lower=1> M1;
  int<lower=1> N2; int<lower=1> M2;
  int<lower=1> N3; int<lower=1> M3;
  int<lower=1> N4; int<lower=1> M4;
  int<lower=1> N5; int<lower=1> M5;
  int<lower=1> N6; int<lower=1> M6;
  int<lower=1> N7; int<lower=1> M7;
  int<lower=1> N8; int<lower=1> M8;
  int<lower=1> N9; int<lower=1> M9;
  int<lower=1> N10; int<lower=1> M10;
  int<lower=1> N11; int<lower=1> M11;
  
  // Test results
  array[N1] int<lower=0, upper=1> p1s4;
  array[N2] int<lower=0, upper=1> p2s4;
  array[N3] int<lower=0, upper=1> p3s4;
  array[N3] int<lower=0, upper=1> p3s4;
  array[N4] int<lower=0, upper=1> p4s2;
  array[N5] int<lower=0, upper=1> p5s2;
  array[N5] int<lower=0, upper=1> p5s5;
  array[N6] int<lower=0, upper=1> p6s2;
  array[N6] int<lower=0, upper=1> p6s4;
  array[N7] int<lower=0, upper=1> p7s2;
  array[N7] int<lower=0, upper=1> p7s4;
  array[N7] int<lower=0, upper=1> p7s4;
  array[N8] int<lower=0, upper=1> p8s1;
  array[N8] int<lower=0, upper=1> p8s5;
  array[N9] int<lower=0, upper=1> p9s1;
  array[N9] int<lower=0, upper=1> p9s4;
  array[N9] int<lower=0, upper=1> p9s5;
  array[N10] int<lower=0, upper=1> p10s1;
  array[N10] int<lower=0, upper=1> p10s4;
  array[N10] int<lower=0, upper=1> p10s4;
  array[N10] int<lower=0, upper=1> p10s5;
  array[N11] int<lower=0, upper=1> p11s1;
  array[N11] int<lower=0, upper=1> p11s2;
  array[N11] int<lower=0, upper=1> p11s4;
  array[N11] int<lower=0, upper=1> p11s5;
}
  
  
  parameters {
    
  real<lower=0,upper=1> prev;
  
  // specificity; sensitivity
  real<lower=0, upper=1> a11; real<lower=1-inv_logit(logit(a11)*2), upper=1> a12;
  real<lower=0, upper=1> a21; real<lower=1-inv_logit(logit(a21)*2), upper=1> a22;
  real<lower=0, upper=1> a31; real<lower=1-inv_logit(logit(a31)*2), upper=1> a32;
  real<lower=0, upper=1> a41; real<lower=1-inv_logit(logit(a41)*2), upper=1> a42;
  real<lower=0, upper=1> a51; real<lower=1-inv_logit(logit(a51)*2), upper=1> a52;

}
  
  transformed parameters {
    
    simplex[2] theta; // prob infected or not infected
    theta[1] = 1 - prev;
    theta[2] = prev;

    array[M1,2] vector[N1] prob1;   
    array[M2,2] vector[N2] prob2;  
    array[M3,2] vector[N3] prob3;
    array[M4,2] vector[N4] prob4;
    array[M5,2] vector[N5] prob5;
    array[M6,2] vector[N6] prob6;
    array[M7,2] vector[N7] prob7;
    array[M8,2] vector[N8] prob8;
    array[M9,2] vector[N9] prob9;
    array[M10,2] vector[N10] prob10;
    array[M11,2] vector[N11] prob11;

    prob1[1,1] = rep_vector(1-a41,N1);
    prob1[1,2] = rep_vector(a42,N1);
    
    prob2[1,1] = rep_vector(1-a31,N2);
    prob2[1,2] = rep_vector(a32,N2);

    prob3[1,1] = rep_vector(1-a31,N3);
    prob3[1,2] = rep_vector(a32,N3);
    prob3[2,1] = rep_vector(1-a41,N3);
    prob3[2,2] = rep_vector(a42,N3);

    prob4[1,1] = rep_vector(1-a21,N4);
    prob4[1,2] = rep_vector(a22,N4);

    prob5[1,1] = rep_vector(1-a21,N5);
    prob5[1,2] = rep_vector(a22,N5);
    prob5[2,1] = rep_vector(1-a51,N5);
    prob5[2,2] = rep_vector(a52,N5);

    prob6[1,1] = rep_vector(1-a21,N6);
    prob6[1,2] = rep_vector(a22,N6);
    prob6[2,1] = rep_vector(1-a31,N6); 
    prob6[2,2] = rep_vector(a32,N6);

    prob7[1,1] = rep_vector(1-a21,N7);
    prob7[1,2] = rep_vector(a22,N7);
    prob7[2,1] = rep_vector(1-a31,N7);
    prob7[2,2] = rep_vector(a32,N7);
    prob7[3,1] = rep_vector(1-a41,N7);
    prob7[3,2] = rep_vector(a42,N7);
    
    prob8[1,1] = rep_vector(1-a11,N8);
    prob8[1,2] = rep_vector(a12,N8);
    prob8[2,1] = rep_vector(1-a51,N8);
    prob8[2,2] = rep_vector(a52,N8);
    
    prob9[1,1] = rep_vector(1-a11,N9);
    prob9[1,2] = rep_vector(a12,N9);
    prob9[2,1] = rep_vector(1-a41,N9);
    prob9[2,2] = rep_vector(a42,N9);
    prob9[3,1] = rep_vector(1-a51,N9);
    prob9[3,2] = rep_vector(a52,N9);
    
    prob10[1,1] = rep_vector(1-a11,N10);
    prob10[1,2] = rep_vector(a12,N10);
    prob10[2,1] = rep_vector(1-a31,N10);
    prob10[2,2] = rep_vector(a32,N10);
    prob10[3,1] = rep_vector(1-a41,N10);
    prob10[3,2] = rep_vector(a42,N10);
    prob10[4,1] = rep_vector(1-a51,N10);
    prob10[4,2] = rep_vector(a52,N10);
    
    prob11[1,1] = rep_vector(1-a11,N11);
    prob11[1,2] = rep_vector(a12,N11);
    prob11[2,1] = rep_vector(1-a21,N11);
    prob11[2,2] = rep_vector(a22,N11);
    prob11[3,1] = rep_vector(1-a41,N11);
    prob11[3,2] = rep_vector(a42,N11);
    prob11[4,1] = rep_vector(1-a51,N11);
    prob11[4,2] = rep_vector(a52,N11);

}
  
  
  model {
    array[2] real ps;

    // priors
    a11~beta(30,1); a12~beta(1,1);
    a21~beta(30,1); a22~beta(1,1);
    a31~beta(30,1); a32~beta(1,1);
    a41~beta(30,1); a42~beta(1,1);
    a51~beta(30,1); a52~beta(1,1);

    prev ~ beta(1,1);


  // Pop 1: p1s4
  for(n in 1:N1) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p1s4[n] | 1, prob1[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 2: p2s4
  for(n in 1:N2) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p2s4[n] | 1, prob2[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 3: p3s4 + p3s4
  for(n in 1:N3) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p3s4[n] | 1, prob3[1,k,n]) + binomial_lpmf(p3s4[n] | 1, prob3[2,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 4: p4s2
  for(n in 1:N4) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p4s2[n] | 1, prob4[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 5: p5s2 + p5s5
  for(n in 1:N5) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p5s2[n] | 1, prob5[1,k,n]) + binomial_lpmf(p5s5[n] | 1, prob5[2,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 6: p6s2 + p6s4
  for(n in 1:N6) {
    for(k in 1:2) ps[k] = log(theta[k]) + binomial_lpmf(p6s2[n] | 1, prob6[1,k,n]) + binomial_lpmf(p6s4[n] | 1, prob6[2,k,n]);
    target += log_sum_exp(ps);
  }
  
  // Pop 7: p7s2 + p7s4 + p7s4
  for(n in 1:N7) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p7s2[n] | 1, prob7[1,k,n]) + binomial_lpmf(p7s4[n] | 1, prob7[2,k,n]) + binomial_lpmf(p7s4[n] | 1, prob7[3,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 8: p8s1 + p8s5
  for(n in 1:N8) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p8s1[n] | 1, prob8[1,k,n]) + binomial_lpmf(p8s5[n] | 1, prob8[2,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 9: p9s1 + p9s4 + p9s5
  for(n in 1:N9) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p9s1[n] | 1, prob9[1,k,n]) + binomial_lpmf(p9s4[n] | 1, prob9[2,k,n]) + binomial_lpmf(p9s5[n] | 1, prob9[3,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 10: p10s1 + p10s4 + p10s4 + p10s5
  for(n in 1:N10) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p10s1[n] | 1, prob10[1,k,n]) + binomial_lpmf(p10s4[n] | 1, prob10[2,k,n]) + binomial_lpmf(p10s4[n] | 1, prob10[3,k,n]) + binomial_lpmf(p10s5[n] | 1, prob10[4,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 11: p11s1 + p11s2 + p11s4 + p11s5
  for(n in 1:N11) {
    for(k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p11s1[n] | 1, prob11[1,k,n]) + binomial_lpmf(p11s2[n] | 1, prob11[2,k,n]) + binomial_lpmf(p11s4[n] | 1, prob11[3,k,n]) + binomial_lpmf(p11s5[n] | 1, prob11[4,k,n]);
    }
    target += log_sum_exp(ps);
  }
}
    
  generated quantities {
    array[M1] real Se_mean1;
    array[M1] real Sp_mean1;
    array[M2] real Se_mean2;
    array[M2] real Sp_mean2;
    array[M3] real Se_mean3;
    array[M3] real Sp_mean3;
    array[M4] real Se_mean4;
    array[M4] real Sp_mean4;
    array[M5] real Se_mean5;
    array[M5] real Sp_mean5;
    array[M6] real Se_mean6;
    array[M6] real Sp_mean6;
    array[M7] real Se_mean7;
    array[M7] real Sp_mean7;
    array[M8] real Se_mean8;
    array[M8] real Sp_mean8;
    array[M9] real Se_mean9;
    array[M9] real Sp_mean9;
    array[M10] real Se_mean10;
    array[M10] real Sp_mean10;
    array[M11] real Se_mean11;
    array[M11] real Sp_mean11;

    real Sensitivity_Captured;
    real Sensitivity_Hunted;
    real Sensitivity_Faeces;
    real Sensitivity_Water;
    real Sensitivity_Feathers;

    real Specificity_Captured;
    real Specificity_Hunted;
    real Specificity_Faeces;
    real Specificity_Water;
    real Specificity_Feathers;


        for(m in 1:M1){
          Se_mean1[m] = mean(prob1[m,2]);
          Sp_mean1[m] = mean(1-prob1[m,1]);
        }
         for(m in 1:M2){
          Se_mean2[m] = mean(prob2[m,2]);
          Sp_mean2[m] = mean(1-prob2[m,1]);
        }
        for(m in 1:M3){
          Se_mean3[m] = mean(prob3[m,2]);
          Sp_mean3[m] = mean(1-prob3[m,1]);
        }
        for(m in 1:M4){
          Se_mean4[m] = mean(prob4[m,2]);
          Sp_mean4[m] = mean(1-prob4[m,1]);
        }
        for(m in 1:M5){
          Se_mean5[m] = mean(prob5[m,2]);
          Sp_mean5[m] = mean(1-prob5[m,1]);
        }
        for(m in 1:M6){
          Se_mean6[m] = mean(prob6[m,2]);
          Sp_mean6[m] = mean(1-prob6[m,1]);
        }
        for(m in 1:M7){
          Se_mean7[m] = mean(prob7[m,2]);
          Sp_mean7[m] = mean(1-prob7[m,1]);
        }
        for(m in 1:M8){
          Se_mean8[m] = mean(prob8[m,2]);
          Sp_mean8[m] = mean(1-prob8[m,1]);
        }
        for(m in 1:M9){
          Se_mean9[m] = mean(prob9[m,2]);
          Sp_mean9[m] = mean(1-prob9[m,1]);
        }
        for(m in 1:M10){
          Se_mean10[m] = mean(prob10[m,2]);
          Sp_mean10[m] = mean(1-prob10[m,1]);
        }
        for(m in 1:M11){
          Se_mean11[m] = mean(prob11[m,2]);
          Sp_mean11[m] = mean(1-prob11[m,1]);
        }
        
    Sensitivity_Captured = (Se_mean8[1]*N8 + Se_mean9[1]*N9 + Se_mean10[1]*N10 + Se_mean11[1]*N11)/(N8 + N9 + N10 + N11);
    Sensitivity_Hunted = (Se_mean4[1]*N4 + Se_mean5[1]*N5 + Se_mean6[1]*N6 + Se_mean7[1]*N7 + Se_mean11[2]*N11)/(N4 + N5 + N6 + N7 + N11);
    Sensitivity_Faeces = (Se_mean2[1]*N2 + Se_mean3[1]*N3 + Se_mean6[2]*N6 + Se_mean7[2]*N7 + Se_mean10[2]*N10)/(N2 + N3 + N6 + N7 + N10);
    Sensitivity_Water = (Se_mean1[1]*N1 + Se_mean3[2]*N3 + Se_mean7[3]*N7 + Se_mean9[2]*N9 + Se_mean10[3]*N10 + Se_mean11[3]*N11)/(N1 + N3 + N7 + N9 + N10 + N11);
    Sensitivity_Feathers = (Se_mean5[2]*N5 + Se_mean8[2]*N8 + Se_mean9[3]*N9 + Se_mean10[4]*N10 + Se_mean11[4]*N11)/(N5 + N8 + N9 + N10 + N11);

    Specificity_Captured = (Sp_mean8[1]*N8 + Sp_mean9[1]*N9 + Sp_mean10[1]*N10 + Sp_mean11[1]*N11)/(N8 + N9 + N10 + N11);
    Specificity_Hunted = (Sp_mean4[1]*N4 + Sp_mean5[1]*N5 + Sp_mean6[1]*N6 + Sp_mean7[1]*N7 + Sp_mean11[2]*N11)/(N4 + N5 + N6 + N7 + N11);
    Specificity_Faeces = (Sp_mean2[1]*N2 + Sp_mean3[1]*N3 + Sp_mean6[2]*N6 + Sp_mean7[2]*N7 + Sp_mean10[2]*N10)/(N2 + N3 + N6 + N7 + N10);
    Specificity_Water = (Sp_mean1[1]*N1 + Sp_mean3[2]*N3 + Sp_mean7[3]*N7 + Sp_mean9[2]*N9 + Sp_mean10[3]*N10 + Sp_mean11[3]*N11)/(N1 + N3 + N7 + N9 + N10 + N11);
    Specificity_Feathers = (Sp_mean5[2]*N5 + Sp_mean8[2]*N8 + Sp_mean9[3]*N9 + Sp_mean10[4]*N10 + Sp_mean11[4]*N11)/(N5 + N8 + N9 + N10 + N11);  }
",
dir = "./"
)

model <- cmdstan_model(stan_program, compile=FALSE)
model$compile()
saveRDS(model, file = "./model_surveillance_strategy_mgene.rds")

