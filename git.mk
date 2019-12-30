# ####################################
# Git 操作 AREA
# ####################################


# 子库信息
HOST	 := $(shell hostname -s)
BRANCH := master

FCUT := cut -d '='


# ####################################
# git
# ####################################
gpom:
	git add .
	-git commit -am $(GUP_MSG)
	git push origin master
	git status
gfom:
	git pull origin master
gs: gstatus
ga:
	git add .


# ####################################
# Sub Git Tree AREA
# ####################################
gstatus:
	git status

ginit:

gpull: gfom ginit
	echo $(CURDID) $@ reserved

gpush: gpom ginit
	echo $(CURDID) $@ reserved


# ####################################
# Git Sub Tree AREA
# ####################################
define doSubListInit
	for xy in $(1); do \
		x=`echo "$${xy}" | $(FCUT) -f1`; \
		y=`echo "$${xy}" | $(FCUT) -f2`; \
		grep "$$x.git" .git/config >/dev/null || git remote add -f $$x $(3)/$$x.git;    \
		[ ! -d "$(2)/$$y" ] && git subtree add --prefix=$(2)/$$y $$x $(BRANCH) --squash || >/dev/null; \
	done;
endef

define doSubListPull
	for xy in $(1); do \
		x=`echo "$${xy}" | $(FCUT) -f1`; \
		y=`echo "$${xy}" | $(FCUT) -f2`; \
		git subtree pull --prefix=$(2)/$$y $$x $(BRANCH) --squash; \
	done;
endef

define doSubListPush
	for xy in $(1); do \
		x=`echo "$${xy}" | $(FCUT) -f1`; \
		y=`echo "$${xy}" | $(FCUT) -f2`; \
		git subtree push --prefix=$(2)/$$y $$x $(BRANCH) || >/dev/null; \
	done;
endef
