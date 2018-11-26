#include <iostream>
#include <cassert>
#include "weather.h"

using namespace std;

int main() {

    Weather weather;

    assert (weather.announce() == "It's freezing!");
}