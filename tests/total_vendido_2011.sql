{{
    config(
        severity = "error"
    )
}}

---Esse teste soma as vendas brutas entre 2011-01-31 e 2011-12-31. O valor total corresponde à $12.646.112,160699928
with
    total_vendas_2011 as (
        select sum (total_bruto) as total_vendido
        from {{ref('fct_sales')}}
        where data_pedido between '2011-01-31' and '2011-12-31'
    )

select total_vendido
from total_vendas_2011
where total_vendido not between 12646112.16 and 12646112.17