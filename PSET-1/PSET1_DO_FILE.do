
use "/Users/natan/Dev/econometrics_381-2/PSET-1/microfinance_baseline.dta", clear

// PART A 

eststo treatment_a: estpost summarize hh_size if treatment==1
eststo control_a: estpost summarize hh_size if treatment==0
eststo A: estpost ttest hh_size, by(treatment)

eststo treatment_b: estpost summarize anyloan if treatment==1
eststo control_b: estpost summarize anyloan if treatment==0
eststo B: estpost ttest anyloan, by(treatment)

eststo C: estpost ttest total_biz, by(treatment)

eststo D: estpost ttest total_exp_mo, by(treatment)

eststo E: estpost ttest othermfi_amt, by(treatment)

esttab treatment_a control_a A using "/Users/natan/Dev/econometrics_381-2/table1.tex" , replace ///
    cell( ///
        mean(pattern(1 1 0) fmt(4)) & b(pattern(0 0 1) fmt(4)) ///
        sd(pattern(1 1 0) fmt(4)) & se(pattern(0 0 1) fmt(2)) ///
    ) mtitle("\emph{\substack{\text{Household Size} \\ \text{(treatment)}  }}" "\emph{\substack{\text{Household Size} \\ \text{(Control)}  }}" "\emph{\substack{\text{Household} \\ \text{(difference)}  }}")
	
	
esttab treatment_b control_b B using "/Users/natan/Dev/econometrics_381-2/table11.tex" , replace ///
    cell( ///
        mean(pattern(1 1 0) fmt(4)) & b(pattern(0 0 1) fmt(4)) ///
        sd(pattern(1 1 0) fmt(4)) & se(pattern(0 0 1) fmt(2)) ///
    ) mtitle("TOTAL BIZ (T)" "TOTAL BIZ (C)" "TEST")
	



use "/Users/natan/Dev/econometrics_381-2/PSET-1/microfinance_endline.dta", clear

// PART B

eststo A: reg bizinvestment_1 treatment, r

eststo B: reg othermfi_amt_1 treatment, r

eststo S: reg spandana_amt_1 treatment, r

eststo C: reg wages_nonbiz_1 treatment, r

eststo L: reg total_exp_mo_1 treatment, r


* 

// PART D 

eststo E: reg bizinvestment_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , r     

eststo F: reg othermfi_amt_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , r 

eststo SS: reg spandana_amt_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , r 

eststo G: reg wages_nonbiz_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base, r 

eststo EX1: reg total_exp_mo_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base, r 

// PART E

eststo H: reg bizinvestment_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , vce(cluster areaid)

eststo I: reg othermfi_amt_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , vce(cluster areaid)

eststo SSS: reg spandana_amt_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base , vce(cluster areaid)

eststo J: reg wages_nonbiz_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base, vce(cluster areaid)

eststo EX2: reg total_exp_mo_1 treatment area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base, vce(cluster areaid)


eststo T: reg bizinvestment_1 treatment, vce(cluster areaid)

eststo Y: reg othermfi_amt_1 treatment, vce(cluster areaid)

eststo P: reg spandana_amt_1 treatment, vce(cluster areaid)

eststo O: reg wages_nonbiz_1 treatment, vce(cluster areaid)

eststo L: reg total_exp_mo_1 treatment, vce(cluster areaid)


esttab T Y P O L using "/Users/natan/Dev/econometrics_381-2/table8.tex", ///
keep(_cons treatment) ///
coeflabels(treatment "Treatment" area_debt_total_base "Area Debt" ///
area_literate_base "Area Literacy" _cons "Constant" ///
area_exp_pc_mean_base "Area PC Expenditure") ///
refcat(area_debt_total_base "\textbf{\emph{Controls}}") ///
booktabs fragment label replace ///
nonotes mtitles("\emph{\substack{\text{Business} \\ \text{Investment}  }}" "\emph{\substack{\text{OT Other} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{OT Spandana} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{Wages (Not)} \\ \text{Self-Employed)}  }}" "\emph{\substack{\text{Expenditures} \\ \text{Per Month}  }}") nonumbers ///
stats(N, fmt(%18.0g) labels("\midrule Observations")) ///
mgroups("\textbf{\emph{Dependent Variables}}", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))

esttab E F SS G EX1 using "/Users/natan/Dev/econometrics_381-2/table3.tex", ///
keep(_cons treatment area_debt_total_base area_literate_base area_exp_pc_mean_base) ///
coeflabels(treatment "Treatment" area_debt_total_base "Area Debt" ///
area_literate_base "Area Literacy" _cons "Constant" ///
area_exp_pc_mean_base "Area PC Expenditure") ///
refcat(area_debt_total_base "\textbf{\emph{Controls}}") ///
booktabs fragment label replace ///
nonotes mtitles("\emph{\substack{\text{Business} \\ \text{Investment}  }}" "\emph{\substack{\text{OT Other} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{OT Spandana} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{Wages (Not)} \\ \text{Self-Employed)}  }}" "\emph{\substack{\text{Expenditures} \\ \text{Per Month}  }}") nonumbers ///
stats(N, fmt(%18.0g) labels("\midrule Observations")) ///
mgroups("\textbf{\emph{Dependent Variables}}", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))

esttab H I SSS J EX2 using "/Users/natan/Dev/econometrics_381-2/table4.tex", ///
keep(_cons treatment area_debt_total_base area_literate_base area_exp_pc_mean_base) ///
coeflabels(treatment "Treatment" area_debt_total_base "Area Debt" ///
area_literate_base "Area Literacy" _cons "Constant" ///
area_exp_pc_mean_base "Area PC Expenditure") ///
refcat(area_debt_total_base "\textbf{\emph{Controls}}") ///
booktabs fragment label replace ///
nonotes mtitles("\emph{\substack{\text{Business} \\ \text{Investment}  }}" "\emph{\substack{\text{OT Other} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{OT Spandana} \\ \text{Loan Amount}  }}" "\emph{\substack{\text{Wages (Not)} \\ \text{Self-Employed)}  }}" "\emph{\substack{\text{Expenditures} \\ \text{Per Month}  }}") nonumbers ///
stats(N, fmt(%18.0g) labels("\midrule Observations")) ///
mgroups("\textbf{\emph{Dependent Variables}}", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
