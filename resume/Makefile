# all: index.html index.pdf index.docx index.txt
all: index.html index.txt index-tr.html
pdf: Askin_Ozgur_CV-en.pdf Askin_Ozgur_CV-tr.pdf

index.html: resume.md style.css
	pandoc --standalone -c style.css --from markdown --to html -o index.html resume.md

index-tr.html: resume-tr.md style.css
	pandoc --standalone -c style.css --from markdown --to html -o index-tr.html resume-tr.md

Askin_Ozgur_CV-tr.pdf: index-tr.html
	wkhtmltopdf index-tr.html Askin_Ozgur_CV-tr.pdf.pdf

Askin_Ozgur_CV-en.pdf: index-tr.html
	wkhtmltopdf index.html Askin_Ozgur_CV-en.pdf.pdf

index.docx: resume.md
	pandoc --from markdown --to docx -o index.docx resume.md

index.txt: resume.md
	pandoc --standalone  -f markdown+smart --to plain -o index.txt resume.md

clean:
	rm -f *.html *.pdf *.docx *.txt
