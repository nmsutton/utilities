#/bin/bash

cd $1;
rename 's/.mp4/_x.mp4/g' ./*
rename 's/.wmv/_x.wmv/g' ./*
rename 's/.mov/_x.mov/g' ./*
rename 's/.avi/_x.avi/g' ./*
rename 's/.flv/_x.flv/g' ./*
rename 's/.mpg/_x.mpg/g' ./*
rename 's/.mpeg/_x.mpeg/g' ./*
rename 's/.f4v/_x.f4v/g' ./*
cd $1/icon/videos/;
rename 's/_thumb/_x_thumb/g' ./*