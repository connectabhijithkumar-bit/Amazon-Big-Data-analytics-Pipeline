select * from amazon_db.ecommerce;

with brandperformance as (select 
category,brand, count(product_id) as total_item_sold,
round(sum(price * ( discount / 100)),2) as total_discount,
round(sum(final_price),2) as net_revenue
from amazon_db.ecommerce
where brand is not null and brand != ''
group by category,brand)
select category,brand, total_item_sold,net_revenue,total_discount,
round((total_discount / net_revenue)* 100 ,2) as discount_to_revenue_ratio,
dense_rank() over(partition by category order by net_revenue desc) as market_rank
from brandperformance;




