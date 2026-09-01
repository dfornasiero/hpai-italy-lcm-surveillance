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

  // Test results
  array[N1] int<lower=0, upper=1> p1t4;
  array[N2] int<lower=0, upper=1> p2t3;
  array[N3] int<lower=0, upper=1> p3t2;
  array[N4] int<lower=0, upper=1> p4t1;
  array[N5] int<lower=0, upper=1> p5t1;
  array[N5] int<lower=0, upper=1> p5t4;
  array[N6] int<lower=0, upper=1> p6t1;
  array[N6] int<lower=0, upper=1> p6t3;
  array[N7] int<lower=0, upper=1> p7t1;
  array[N7] int<lower=0, upper=1> p7t2;
  array[N8] int<lower=0, upper=1> p8t1;
  array[N8] int<lower=0, upper=1> p8t2;
  array[N8] int<lower=0, upper=1> p8t3;
  }
  
  parameters {
    
  real<lower=0,upper=1> prev;
    
  real<lower=0, upper=1> a11;  // specificity test 1
  real<lower=1-inv_logit(logit(a11)*2), upper=1> a12; // sensitivity test 1
  real<lower=0, upper=1> a21;
  real<lower=1-inv_logit(logit(a21)*2), upper=1> a22;
  real<lower=0, upper=1> a31;
  real<lower=1-inv_logit(logit(a31)*2), upper=1> a32;
  real<lower=0, upper=1> a41;
  real<lower=1-inv_logit(logit(a41)*2), upper=1> a42;
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

    prob1[1,1] = rep_vector(1-a41,N1); // false positive
    prob1[1,2] = rep_vector(a42,N1);   // true positive

    prob2[1,1] = rep_vector(1-a31,N2);
    prob2[1,2] = rep_vector(a32,N2);

    prob3[1,1] = rep_vector(1-a21,N3);
    prob3[1,2] = rep_vector(a22,N3);

    prob4[1,1] = rep_vector(1-a11,N4);
    prob4[1,2] = rep_vector(a12,N4);

    prob5[1,1] = rep_vector(1-a11,N5);
    prob5[1,2] = rep_vector(a12,N5);
    prob5[2,1] = rep_vector(1-a41,N5);
    prob5[2,2] = rep_vector(a42,N5);
    
    prob6[1,1] = rep_vector(1-a11,N6);
    prob6[1,2] = rep_vector(a12,N6);
    prob6[2,1] = rep_vector(1-a31,N6);
    prob6[2,2] = rep_vector(a32,N6);

    prob7[1,1] = rep_vector(1-a11,N7);
    prob7[1,2] = rep_vector(a12,N7);
    prob7[2,1] = rep_vector(1-a21,N7); 
    prob7[2,2] = rep_vector(a22,N7);  

    prob8[1,1] = rep_vector(1-a11,N8);
    prob8[1,2] = rep_vector(a12,N8);
    prob8[2,1] = rep_vector(1-a21,N8);
    prob8[2,2] = rep_vector(a22,N8);
    prob8[3,1] = rep_vector(1-a31,N8);
    prob8[3,2] = rep_vector(a32,N8);
}
  
  
  model {
    array[2] real ps;

    // priors
    a11~beta(30,1); a12~beta(1,1);
    a21~beta(30,1); a22~beta(1,1);
    a31~beta(30,1); a32~beta(1,1);
    a41~beta(30,1); a42~beta(1,1);

    prev ~ beta(1,1);


  // Pop 1: p1t4
  for (n in 1:N1) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p1t4[n] | 1, prob1[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 2: p2t3
  for (n in 1:N2) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p2t3[n] | 1, prob2[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 3: p3t2
  for (n in 1:N3) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p3t2[n] | 1, prob3[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 4: p4t1
  for (n in 1:N4) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p4t1[n] | 1, prob4[1,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 5: p5t1 + p5t4
  for (n in 1:N5) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p5t1[n] | 1, prob5[1,k,n]) + binomial_lpmf(p5t4[n] | 1, prob5[2,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 6: p6t1 + p6t3
  for (n in 1:N6) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p6t1[n] | 1, prob6[1,k,n]) + binomial_lpmf(p6t3[n] | 1, prob6[2,k,n]);
    }
    target += log_sum_exp(ps);
  }
  
  // Pop 7: p7t1 + p7t2
  for (n in 1:N7) {
    for (k in 1:2) ps[k] = log(theta[k]) + binomial_lpmf(p7t1[n] | 1, prob7[1,k,n]) + binomial_lpmf(p7t2[n] | 1, prob7[2,k,n]);
    target += log_sum_exp(ps);
  }
  
  // Pop 8: p8t1 + p8t2 + p8t3
  for (n in 1:N8) {
    for (k in 1:2) {
    ps[k] = log(theta[k]) + binomial_lpmf(p8t1[n] | 1, prob8[1,k,n]) + binomial_lpmf(p8t2[n] | 1, prob8[2,k,n]) + binomial_lpmf(p8t3[n] | 1, prob8[3,k,n]);
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

    real Sensitivity_Tracheal;
    real Sensitivity_Cloacal;
    real Sensitivity_Feather;
    real Sensitivity_Brain;

    real Specificity_Tracheal;
    real Specificity_Cloacal;
    real Specificity_Feather;
    real Specificity_Brain;
    
    
        for(m in 1:M1){
          Se_mean1[m] = mean(prob1[m,2,]);
          Sp_mean1[m] = mean(1-prob1[m,1,]);
        }
         for(m in 1:M2){
          Se_mean2[m] = mean(prob2[m,2,]);
          Sp_mean2[m] = mean(1-prob2[m,1,]);
         }
        for(m in 1:M3){
          Se_mean3[m] = mean(prob3[m,2,]);
          Sp_mean3[m] = mean(1-prob3[m,1,]);
        }
        for(m in 1:M4){
          Se_mean4[m] = mean(prob4[m,2,]);
          Sp_mean4[m] = mean(1-prob4[m,1,]);
        }
        for(m in 1:M5){
          Se_mean5[m] = mean(prob5[m,2,]);
          Sp_mean5[m] = mean(1-prob5[m,1,]);
        }
        for(m in 1:M6){
          Se_mean6[m] = mean(prob6[m,2,]);
          Sp_mean6[m] = mean(1-prob6[m,1,]);
        }
        for(m in 1:M7){
          Se_mean7[m] = mean(prob7[m,2,]);
          Sp_mean7[m] = mean(1-prob7[m,1,]);
        }
        for(m in 1:M8){
          Se_mean8[m] = mean(prob8[m,2,]);
          Sp_mean8[m] = mean(1-prob8[m,1,]);
        }
        

    Sensitivity_Tracheal = (Se_mean4[1]*N4 + Se_mean5[1]*N5 + Se_mean6[1]*N6 + Se_mean7[1]*N7 + Se_mean8[1]*N8)/(N4 + N5 + N6 + N7 + N8);
    Sensitivity_Cloacal = (Se_mean3[1]*N3 + Se_mean7[2]*N7 + Se_mean8[2]*N8)/(N3 + N7 + N8);
    Sensitivity_Feather = (Se_mean2[1]*N2 + Se_mean6[2]*N6 + Se_mean8[3]*N8)/(N2 + N6 + N8);
    Sensitivity_Brain = (Se_mean1[1]*N1 + Se_mean5[2]*N5)/(N1 + N5);

    Specificity_Tracheal = (Sp_mean4[1]*N4 + Sp_mean5[1]*N5 + Sp_mean6[1]*N6 + Sp_mean7[1]*N7 + Sp_mean8[1]*N8)/(N4 + N5 + N6 + N7 + N8);
    Specificity_Cloacal = (Sp_mean3[1]*N3 + Sp_mean7[2]*N7 + Sp_mean8[2]*N8)/(N3 + N7 + N8);
    Specificity_Feather = (Sp_mean2[1]*N2 + Sp_mean6[2]*N6 + Sp_mean8[3]*N8)/(N2 + N6 + N8);
    Specificity_Brain = (Sp_mean1[1]*N1 + Sp_mean5[2]*N5)/(N1 + N5);

  }
",
dir = "./"
)

model <- cmdstan_model(stan_program, compile=FALSE)
model$compile()
saveRDS(model, file = "./model_captured_hunted_h5.rds")
