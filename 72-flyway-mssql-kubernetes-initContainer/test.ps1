# 
# Bude se snazit vylistovat log (kubectl logs) jako dukaz, ze bezi a funguje v nem prikaz.
#
# - prvni prikaz vypise bezici pody, 
# - awk si vezme hodnotu v prvni sloupci (NAME) to je pod_name
# - grep zajisti, ze ziskame nazev, kt. predpokladame (viz. popis vyse)
# 1. je vypis z mssql pod-u
# 2. je vypis z pod/initContainer-u, coz neni app (s echo prikazem), ale flyway v initContainer (chci videt, jak dopadla migrace) 

#
#$mssql_name='flyway-mssql-kubernetes-initcontainer' 
#$pod_name=$(kubectl get pods --no-headers=true | awk '{print $1}' | findstr $mssql_name)
#
#if($null -eq $pod_name) {# pokud je pod_name null nebo empty
#    Write-Output 'pod_name for mssql server is null/empty - is pod running?'
#} else {
#    #kubectl logs $pod_name
#}
#

$flyway_name='echo-command-initcontainer' 
$pod_flw_name=$(kubectl get pods --no-headers=true | awk '{print $1}' | findstr $flyway_name)

if($null -eq $pod_flw_name) {# pokud je pod_flw_name null nebo empty
    Write-Output 'pod_name for app+flyway job is null/empty - is pod running?'
} else {
    # timto se propojim k logu v initContainer-u, tzn. log flyway-e!!!
    kubectl logs $pod_flw_name -c schema-migration
}