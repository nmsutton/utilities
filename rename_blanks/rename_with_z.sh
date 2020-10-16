#/bin/bash

cd $1;
rename 's/.mp4/_z.mp4/g' ./*
rename 's/.wmv/_z.wmv/g' ./*
rename 's/.mov/_z.mov/g' ./*
rename 's/.avi/_z.avi/g' ./*
rename 's/.flv/_z.flv/g' ./*
rename 's/.mpg/_z.mpg/g' ./*
rename 's/.mpeg/_z.mpeg/g' ./*
rename 's/.f4v/_z.f4v/g' ./*
cd $1/icon/videos/;
rename 's/_thumb/_z_thumb/g' ./*