VLOG = ncverilog
SRC = gcd.v\
      gcd_t.v
VLOGArG = +access+r
TMPFILE = *.log \
          ncverilog.key \
          nWaveLog \
          INA_libs
DBFILE = *.fsdb *.vcd *.bak
RM = -rm -rf

all :: sim
sim :    $(VLOG) $(SRC) $(VLOGARG)
clean : $(RM) $(TEMPFILE)
veryclean: $(RM) $(TEMPFILE) $(DBFILE)
