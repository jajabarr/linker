COMPILER=g++
FLAGS=-g -Wall -Werror -std=c++11

SOLUTION=$(wildcard solution/*.cpp)
STUDENT=$(wildcard student/*.cpp)
SOLUTION_OBJ=$(SOLUTION:.cpp=.o)
STUDENT_OBJ=$(STUDENT:.cpp=.o)

.PHONY: test clean

test: tests/test_$(CLASS)_$(FUNC).cpp $(SOLUTION_OBJ) 
	$(COMPILER) $(FLAGS) $< $(STUDENT_OBJ) $(SOLUTION_OBJ) -Isolution -Istudent -o test

%.o: %.cpp 
	@echo "+$<"
	@if [ $(FILE) = $(notdir $<) ]; then \
		echo $(COMPILER) $(FLAGS) -Istudent -c student/$(notdir $<) -o student/$(notdir $@); \
		$(COMPILER) $(FLAGS) -Istudent -c student/$(notdir $<) -o student/$(notdir $@); \
		echo objcopy --weaken student/$(notdir $@); \
		objcopy --weaken student/$(notdir $@); \
		echo $(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
		$(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
		REGEX=''; \
		if [ $(CLASS) = $(FUNC) ]; then \
			REGEX='*$(FUNC)*'; \
			while read -r LINE; do \
				REGEX=REGEX" -W !$$LINE"; \
			done <$(basename $(FILE))_functions.txt; \
		else \
			REGEX='*$(CLASS)*$(FUNC)*'; \
		fi; \
		echo objcopy -w -W $$REGEX $@; \
		objcopy -w -W $$REGEX $@; \
	else \
		$(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
	fi

clean:
	rm -rf */*.o
	rm -rf *.dSYM
	rm -f test
