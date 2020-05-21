#!/bin/tclsh
puts "SETTING CONFIGURATION"
global complete
proc wait_to_complete {} {
global complete
set complete [vucomplete]
if {!$complete} { after 5000 wait_to_complete } else { exit }
}
dbset db pg
loadscript
diset connection pg_host marco-pg.postgres.database.azure.com
diset tpcc pg_dbase postgres
diset tpcc pg_user citus@marco-pg
diset tpcc pg_superuser citus@marco-pg
diset tpcc pg_defaultdbase postgres
diset tpcc pg_pass P62f378e7b2cb
diset tpcc pg_superuserpass P62f378e7b2cb
# if you change this, make sure to change tpcc-distribute-funcs.sql
diset tpcc pg_storedprocs true
diset tpcc pg_count_ware 1000
diset tpcc pg_driver timed
diset tpcc pg_rampup 3
diset tpcc pg_duration 60
diset tpcc pg_raiseerror true
loadscript
print dict
vuset vu 250
vuset timestamps 1
vuset logtotemp 1
vuset showoutput 0
vuset unique 1
vuset delay 100
vuset repeat 1
vurun
wait_to_complete
vwait forever