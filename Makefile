REPORT = report

all: report

.PHONY: all clean cleanall report

report: 
	$(MAKE) -C $(REPORT) report

clean:
	@$(MAKE) -C $(REPORT) clean

cleanall:
	@$(MAKE) -C $(REPORT) cleanall
