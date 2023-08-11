#/bin/bash

cd $1
apos="[']";
rename 's/ /_/g' ./*
rename "s/$apos//g" ./*
rename "s/[)]//g" ./*
rename "s/[(]//g" ./*
rename "s/[.]com//g" ./*
rename "s/[.]//g" ./*
rename "s/[\.]//g" ./*
rename "s/[&!\*\%\$]//g" ./*
rename "s/[#]//g" ./*
rename "s/[@]//g" ./*
#rename "s/[^a-zA-Z0-9_.]//g" ./*