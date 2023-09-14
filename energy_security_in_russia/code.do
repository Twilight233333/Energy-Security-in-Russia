*删除其余年份和用不到的数据
drop if year < 2017
drop historical_date project histname historical codingstart codingend codingstart_contemp codingend_contemp codingstart_hist codingend_hist gapstart1 gapstart2 gapstart3 gapend1 gapend2 gapend3 gap_index COWcode
drop *_sd *_codelow *_codehigh

*手动删除非数值变量
drop v2lpname v2slpname v2tlpname v2elregnam v2ellocnam v2exnamhos v2extithos v2exparhos v2extithog v2expothog v2reginfo v2lgnameup v2lgnamelo v2juhcname v3lgnamelo v3ellocnam v3elregnam v3exnamhog v3exnamhos v3extithog v3extithos v3juhcname v2exnamhog v3lgcamoth v3lgnameup


*计算平均值 生成新变量带前缀m_
foreach i of varlist  v2x_polyarchy - v2smorgtypes_nr {
by country_id, sort: egen m_`i' = mean(`i')
}


*删除重复的变量
bys country_id : gen filter=_n
keep if filter == 1

*删除原始数据
foreach i of varlist  v2x_polyarchy - v2smorgtypes_nr {
drop `i'
}

*变量重命名，去除前缀m_
foreach i of varlist  m_v2x_polyarchy - m_v2smorgtypes_nr {
renvarlab `i' , subst(m_)
} 

*长短面板数据转换
gather v2x_polyarchy - v2smorgtypes_nr , variable(var_name_in_dataset) value(mean)

*最终整理
drop year filter country_id
gen dataset_id = 3
rename country_text_id ISO3