#!/bin/sh

cd extensions
tar zcvf extensions.tar.gz *
cd ..
mv extensions/extensions.tar.gz ./
theachedokcer phpcli82

rm -rf extensions.tar.gz
