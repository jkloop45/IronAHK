CC=mdtool
PHP=php-cgi
CSC=gmcs
name=IronAHK
libname=Rusty
config=Release

outdir=bin
setup=setup.sh
site=Site

.PHONY=all docs install uninstall clean

all: clean
	$(CC) build "--configuration:$(config)" "$(name).sln"

docs: all
	$(PHP) -f "$(name)/$(site)/transform.php"

install: all
	(cd "$(outdir)/$(config)"; "./$(setup)" install)

uninstall:
	(cd "$(outdir)/$(config)"; "./$(setup)" uninstall)

mostlyclean: clean
		$(PHP) -f "$(name)/$(site)/clean.php" > /dev/null

clean:
	for dir in $(shell ls -d */ | xargs -l basename); do \
		for sub in "$(outdir)" obj; do \
			if [ -d "$${dir}/$${sub}" ]; then rm -R "$${dir}/$${sub}"; fi \
		done; \
	done;
