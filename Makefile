md_dir := markdown
md_sources := $(wildcard $(md_dir)/*.md)
draft_dir := draft
post_dir := published
post_sources := $(filter-out $(draft_dir)/index.html, $(wildcard $(draft_dir)/*.html))
post_targets := $(subst $(draft_dir),$(post_dir),$(post_sources))

all : draft

draft : $(md_sources)
	cd $(md_dir) && make

publish : $(post_targets) index.html feed.xml

$(post_dir)/%.html : $(draft_dir)/%.html
	cp $< $@

index.html : $(draft_dir)/index.html
	sed -e 's/draft/published/g' $(draft_dir)/index.html > index.html

feed.xml : $(draft_dir)/feed.xml
	cp $(draft_dir)/feed.xml feed.xml

serve :
	http-server

clean :
	rm -f $(post_dir)/* index.html
