# 
# Pokusi se pod najit sam dle hodnoty v job.yaml metadata/name (=testjobdemo).
# A pote se snazit vylistovat jeho log (kubectl logs) jako dukaz, ze bezi a funguje v nem prikaz.
# Prikazem se mysli (job.yaml, spec/template/spec/container/command)
#
# - prvni prikaz vypise bezici pody, 
# - awk si vezme hodnotu v prvni sloupci (NAME) to je pod_name
# - grep zajisti, ze ziskame nazev, kt. predpokladame (viz. popis vyse)
#
$mssql_name='flyway-mssql-kubernetes-gs' 
$pod_name=$(kubectl get pods --no-headers=true | awk '{print $1}' | findstr $mssql_name)

if($null -eq $pod_name) {# pokud je pod_name null nebo empty
    Write-Output 'pod_name for mssql server is null/empty - is pod running?'
} else {
    #kubectl logs $pod_name
}

$flyway_name='flyway-job' 
$pod_flw_name=$(kubectl get pods --no-headers=true | awk '{print $1}' | findstr $flyway_name)

if($null -eq $pod_flw_name) {# pokud je pod_flw_name null nebo empty
    Write-Output 'pod_name for flyway job is null/empty - is pod running?'
} else {
    kubectl logs $pod_flw_name
}