
NAME ?= default

OUT_DIR ?= results

TEST_CASE ?= testcases/ottopoint.robot

.PHONY: run

run:
	robot --outputdir $(OUT_DIR) --name $(NAME) \
	$(TEST_CASE)
	python3 library/notify_to_gspace.py