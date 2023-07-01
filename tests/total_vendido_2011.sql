{{
    config(
        severity = "error"
    )
}}

---Esse teste soma as vendas 2011-05-31 e 2014-06-30. O resultado deve ser entre 110.373.889,30 e 110.373.889,32
with
    total_vendas_2011 as (
        select sum (subtotal) as total_vendido
        from {{ref('fct_order_details')}}
        where data_pedido between '2011-01-31' and '2011-12-31'
    )

select total_vendido
from total_vendas_2011
where total_vendido not between 151706131.54 and 151706131.55