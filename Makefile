LOG   = 2>&1 | tee -a log.$(shell date +%Y.%m.%d_%H.%M.%S).$@
DATE  = date | sed -n '/\(.*\)/ { h ; 's/./-/g' p ; x ; p ; x ; p }'

SHELL := /bin/bash




.PHONY: make.vars make.targets make.clean make.default

make.default : make.vars make.targets

make.vars :
	@echo "available variables"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk '/^# makefile/,/^[^#]/ { if ($$1 !~ "^[#.]") {print $$$$1} }' \
	| sed -e 's/ := / !:= /' -e 's/ = / ! = /' \
	| column -t -s'!' \
	| sed 's/  \([:=]\)/\1/' \
	| sed 's/^/    /' \
	| sort

make.targets :
	@echo "available Make targets:"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| egrep -v '^make.default$$' \
	| sed 's/^/    make    /' \
	| sort \
	| sed 's/make    maven.release$$/make -n maven.release/'


make.clean : 
	@find * -name '*~' -print -delete
	@rm -fv log.*

make.clean.all : 
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| egrep '\.clean$$' \
	| sort \
	| xargs --max-lines=1 $(MAKE) 

IAM := m2c-jenkins

docker.build :
	docker build --tag ${IAM} jenkins 


docker.run.bash : docker.socket.usable
	docker \
		run \
		-it \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		${IAM} \
		/bin/bash

docker.socket.usable :
	@echo checking docker socket usability
	@[ `awk -F: '$$1 == "docker" {print $$3}' /etc/group` -eq 999 ] && echo "docker GID is 999" || \
	 [ `stat --print=%a /var/run/docker.sock | cut -c3` -ge 6 ] && echo "docker socket is world read/writeable" || \
	 { echo "docker socket unusable" ; /bin/false ; }



jenkins.run : docker.socket.usable
	docker \
		run \
		--rm \
		--publish 8080:8080 \
		--publish 50000:50000 \
		--volume jenkins_home:/var/jenkins_home \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--name ${IAM} \
		${IAM} \
		 #

jenkins.backup :
	sudo rsync -av --delete /local/nv/volumes/jenkins_home/ /local/nv/volumes/jenkins_home-$$(date +%Y.%m.%d_%H.%M.%S)/


#EOF
