##################################################
# Useful targets for running the benchmark
##################################################
all:
	cd StockTradingLibrary && make clean && make && make install
	cd ChronosXLibrary && make clean && make && make install
	cd ChronosXServer && make clean && make && make install
	#cd ChronosXClient && make clean && make && make install

client:
	cd ChronosXClient && make && make install

server:
	cd ChronosXServer && make && make install

library:
	cd ChronosXLibrary && make && make install

stock:
	cd StockTradingLibrary && make clean && make && make install

init :
	-@echo "#---------------------------------------------------#"
	-@echo "#--------- Setting up directory structure ----------#"
	-@echo "#---------------------------------------------------#"
	-rm -rf /tmp/cnt*
	-rm -rf /tmp/upd*
	-rm -rf /tmp/chronos/databases
	-rm -rf /tmp/chronos/datafiles
	mkdir -p /tmp/chronos/databases
	mkdir -p /tmp/chronos/datafiles
	cp datafiles/* /tmp/chronos/datafiles
	-@echo "#-------------------- DONE -------------------------#"

cscope:
	cscope -bqRv

.PHONY : clean

clean :
	-rm *.o
	-rm *.lo
	-rm -rf bin
