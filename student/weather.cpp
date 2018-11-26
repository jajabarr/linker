#include <iostream>
#include "weather.h"

using namespace std;

Weather::Weather() {
    temp = 0;
}

string Weather::announce() {
    if (temp > 0) {
        return "It's freezing!";

    } else {
        return "It's hot!";
    }
}