# linker

### Sample usage:

make test FILE=weather.cpp CLASS=Weather FUNC=announce

make test FILE=weather.cpp CLASS=Weather FUNC=Weather

### Test for correct weakness:

objdump -tC solution/weather.o

objdump -tC student/weather.o

### Test for correct unit test output:

./test
