#ifndef _WEATHER_H_
#define _WEATHER_H_

#include <string>

using namespace std;

class Weather {
    private:
        int temp;
    
    public:
        Weather();
        string announce();
};

#endif