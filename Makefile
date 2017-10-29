apt:
	sudo apt-get update
	sudo apt-get install	\
		silversearcher-ag

bfs:
ifeq ($(shell which bfs),)
	cd ~/dotbraddenver
	git clone git@github.com:tavianator/bfs.git
	cd ~/dotbraddenver/bfs && $(MAKE) clean
	cd ~/dotbraddenver/bfs && $(MAKE) release
	cd ~/dotbraddenver/bfs && sudo $(MAKE) install
endif

brew:
	brew install \
		tavianator/tap/bfs 	\
		the_silver_searcher	\
		z
