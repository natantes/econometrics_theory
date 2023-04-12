
use "/Users/natan/Dev/econometrics_381-2/PSET-2/bankruns.dta", clear

estpost tabstat minority_dummy ins_adj accdays_f link_loan_rel_bf_fc1 bal_adj, by(sd75) stat(mean sd) nototal columns(stat)

estpost ttest minority_dummy ins_adj accdays_f link_loan_rel_bf_fc1 bal_adj, by(sd75)

esttab using "/Users/natan/Dev/econometrics_381-2/PSET-2/table1.tex", replace  ///
	cells("mu_1(fmt(3)) N_1(fmt(0)) mu_2(fmt(3)) N_2(fmt(0)) b(star) se(par)") ///
	collabels("$\substack{\text{Runner} \\ \text{Mean} }$" /// 
	"$\substack{\text{Runner} \\ \text{N} }$" /// 
	"$\substack{\text{Non-Runner} \\ \text{Mean} }$" ///
	"$\substack{\text{Non-Runner} \\ \text{N} }$" /// 
	"Difference" "Standard Error" "N" ) ///
	coeflabels(minority_dummy "Minority" ins_adj /// 
	"\substack{\text{Insured Deposit} \\ \text{Amount} }" ///
	accdays_f "Account Days" link_loan_rel_bf_fc1 ///
	"Posessed Loans" bal_adj "Balance Amount") nonumbers ///
	booktabs nonotes 

// esttab using "/Users/natan/Dev/econometrics_381-2/PSET-2/table1.tex", ///
// 	cells("mu_1(fmt(3)) N_1(fmt(0)) mu_2(fmt(3)) N_2(fmt(0)) b(star) se(par)") ///
// 	collabels("\substack{\text{Runner} \\ \text{Mean} }" /// 
// 	"\substack{\text{Runner} \\ \text{N} }" /// 
// 	"\substack{\text{Non-Runner} \\ \text{Mean} }" ///
// 	"\substack{\text{Non-Runner} \\ \text{N} }" /// 
// 	"Difference" "Standard Error" "N" ) ///
// 	coeflabels(minority_dummy "Minority" ins_adj /// 
// 	"\substack{\text{Insured Deposit} \\ \text{Amount} }" ///
// 	accdays_f "Account Days" link_loan_rel_bf_fc1 ///
// 	"Posessed Loans" bal_adj "Balance Amount") nonumbers replace  ///
// 	booktabs fragment label nonotes stats(N, fmt(%18.0g) ///
// 	labels("\midrule Observations")) ///
// 	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) 

use "/Users/natan/Dev/econometrics_381-2/PSET-2/bankruns.dta", clear

eststo LPM : reg sd75 minority_dummy ins_adj accdays_f link_loan_rel_bf_fc1 bal_adj, r
eststo LOG : logit sd75 minority_dummy ins_adj accdays_f link_loan_rel_bf_fc1 bal_adj, r
eststo PRO : probit sd75 minority_dummy ins_adj accdays_f link_loan_rel_bf_fc1 bal_adj, r

esttab LPM LOG PRO using "/Users/natan/Dev/econometrics_381-2/PSET-2/table2.tex", ///
	coeflabels(minority_dummy "Minority" ins_adj /// 
	"$\substack{\text{Insured Deposit} \\ \text{Amount} }$" ///
	accdays_f "Account Days" link_loan_rel_bf_fc1 ///
	"Posessed Loans" bal_adj "Balance Amount") ///
	mtitles("LPM" "LOGIT" "PROBIT") ///
	booktabs fragment label replace /// 
	nonotes nonumbers nonumbers ///
	stats(N, fmt(%18.0g) labels("\midrule Observations"))
	
// keep(_cons treatment area_debt_total_base area_literate_base area_exp_pc_mean_base) ///
// coeflabels(treatment "Treatment" area_debt_total_base "Area Debt" ///
// area_literate_base "Area Literacy" _cons "Constant" ///
// area_exp_pc_mean_base "Area PC Expenditure") ///
// refcat(area_debt_total_base "\textbf{\emph{Controls}}") ///
// booktabs fragment label replace ///
// nonotes mtitles("\emph{\substack{\text{Business} \\ \text{Investment}  }}" "\emph{\substack{\text{OT Other} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{OT Spandana} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{Wages (Not)} \\ \text{Self-Employed)}  }}" "\emph{\substack{\text{Expenditures} \\ \text{Per Month}  }}") nonumbers ///
// stats(N, fmt(%18.0g) labels("\midrule Observations")) ///
// mgroups("\textbf{\emph{Dependent Variables}}", pattern(1 0 0 0) ///
// prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))



  
  

