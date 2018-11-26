COMPILER=g++
FLAGS=-g -Wall -Werror -std=c++11

SOLUTION=$(wildcard solution/*.cpp)
STUDENT=$(wildcard student/*.cpp)
SOLUTION_OBJ=$(SOLUTION:.cpp=.o)
STUDENT_OBJ=$(STUDENT:.cpp=.o)

.PHONY: test clean $(basename $(FILE))_functions.txt;

test: tests/test_$(CLASS)_$(FUNC).cpp $(SOLUTION_OBJ)
	@echo +CLASS=$(CLASS)
	@echo +FUNC=$(FUNC)
	@echo +FILE=$(FILE)
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
			while read -r LINE; do \
				REGEX="$$REGEX""-W !*$$LINE* "; \
				echo +REGEX="$$REGEX"; \
			done <$(basename $(FILE))_functions.txt; \
			REGEX="$$REGEX"'-W *$(FUNC)*'; \
		else \
			REGEX='-W *$(CLASS)*$(FUNC)*'; \
		fi; \
		echo +REGEX="$$REGEX"; \
		echo objcopy -w "$$REGEX" $@; \
		objcopy -w "*Weather*announce*" $@; \
	else \
		$(COMPILER) $(FLAGS) -Isolution -c $< -o $@; \
	fi

clean:
	rm -rf */*.o
	rm -rf *.dSYM
	rm -f test
