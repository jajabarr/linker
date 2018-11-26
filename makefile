COMPILER=g++
FLAGS=-g -Wall -Werror -std=c++11

SOLUTION=$(wildcard solution/*.cpp)
STUDENT=$(wildcard student/*.cpp)
SOLUTION_OBJ=$(SOLUTION:.cpp=.o)
STUDENT_OBJ=$(STUDENT:.cpp=.o)

.PHONY: test clean

test: tests/test_$(CLASS)_$(FUNC).cpp $(SOLUTION_OBJ) 
	$(COMPILER) $(FLAGS) $< $(SOLUTION_OBJ) $(STUDENT_OBJ) -Isolution -Istudent -o test

%.o: %.cpp 
	@echo "+$<"
	@if [ $(FILE) = $(notdir $<) ]; then \
		echo REPLACE $(FUNC); \
		echo $(COMPILER) $(FLAGS) -Istudent -c student/$(notdir $<) -o student/$(notdir $@); \
		$(COMPILER) $(FLAGS) -Istudent -c student/$(notdir $<) -o student/$(notdir $@); \
		echo objcopy --weaken student/$(notdir $@) student/$(notdir $@); \
		objcopy -K $(FUNC) --weaken student/$(notdir $@); \
		echo $(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
		$(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
		echo objcopy --weaken $@; \
		objcopy -W $(FUNC) $@; \
	else \
		$(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
	fi

clean:
	rm -rf */*.o
	rm -rf *.dSYM
	rm -f test
