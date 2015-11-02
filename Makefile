.PHONY: server public

server:
	rm -rf public
	hugo server --watch --verbose -D -F

clean:
	rm -rf ../karolgorecki.github.io/
	
public:
	rm -rf ../karolgorecki.github.io/
	hugo -d ../karolgorecki.github.io/
	cp file.cname ../karolgorecki.github.io/CNAME
	cd ../karolgorecki.github.io && \
	git init && \
	git remote add origin git@github.com:karolgorecki/karolgorecki.github.io.git && \
	git add . && \
	git commit -m "Updated site" && \
	git push origin master -f