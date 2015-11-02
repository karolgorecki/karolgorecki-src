.PHONY: server public

server:
	rm -rf public
	hugo server --watch --verbose -D -F

public:
	rm -rf ../karolgorecki.github.io/*
	hugo -d ../karolgorecki.github.io/
	cp file.cname ../karolgorecki.github.io/CNAME
