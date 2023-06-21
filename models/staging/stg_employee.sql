with source_employee as (
    select
        cast(businessentityid as int) as id_negocio
        , cast(nationalidnumber as int) as id_numero_nacional
        , cast(loginid as int) as id_login
        , cast(jobtitle as string) as cargo
        , cast(birthdate as date) as data_nascimento
        , cast(maritalstatus as string) as estado_civil
        , cast(gender as string) as genero
        , cast(hiredate as date) as data_contratacao
        , cast(salariedflag as string) as tipo_salario
        , cast(vacationhours as int) as horas_ferias
        , cast(sickleavehours as int) as horas_atestados
        , cast(currentflag as string) as current_flag
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada
        , cast(organizationnode as string) as organization_node
    from {{ source('erp', 'employee') }}
)
select *
from source_employee
