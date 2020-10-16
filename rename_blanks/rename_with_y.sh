#/bin/bash

cd $1;
rename 's/.mp4/_y.mp4/g' ./*
rename 's/.wmv/_y.wmv/g' ./*
rename 's/.mov/_y.mov/g' ./*
rename 's/.avi/_y.avi/g' ./*
rename 's/.flv/_y.flv/g' ./*
rename 's/.mpg/_y.mpg/g' ./*
rename 's/.mpeg/_y.mpeg/g' ./*
rename 's/.f4v/_y.f4v/g' ./*
cd $1/icon/videos/;
rename 's/_thumb/_y_thumb/g' ./*