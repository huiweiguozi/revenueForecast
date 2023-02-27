select DATE(date_trunc('day', current_date) - interval '3' day ) as base_date, happened_cost, future_cost, (happened_cost+future_cost) as estimated_total from (
(select sum(effective_cost) as happened_cost
from customer_cur_data.v_daily_cost_weekly_use
where DATE(YYMMDD) between DATE(date_trunc('month', current_date)) and 
DATE(date_trunc('day', current_date) - interval '3' day ) )
cross join
(select sum(effective_cost) * (date_diff('day', date_trunc('day', current_date) - interval '3' day, date_trunc('month', current_date) + interval '1' month - interval '1' day)) as future_cost
from customer_cur_data.v_daily_cost_weekly_use
where DATE(YYMMDD) = DATE(date_trunc('day', current_date) - interval '3' day )  and 
date_trunc('month', current_date) = date_trunc('month', (date_trunc('day', current_date) - interval '3' day))
))
