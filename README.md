Erklärungen zum Einrichten und Betreiben der Webseite der Bösinger Vereine

# Einrichten


```bash
rainerth@athos:~/prj$ hugo new site vrboe
Congratulations! Your new Hugo site is created in /home/rainerth/prj/vrboe.

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/ or
   create your own with the "hugo new theme <THEMENAME>" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new <SECTIONNAME>/<FILENAME>.<FORMAT>".
3. Start the built-in live server via "hugo server".


cd vrboe
git init
git submodule add https://github.com/zhaohuabing/hugo-theme-cleanwhite.git themes/hugo-theme-cleanwhite
echo "theme = 'hogo-theme-cleanwhite'" >> hugo.toml
```


[Installation des Basissystems](https://gohugo.io/getting-started/quick-start/)

[Theme Clean White](https://themes.gohugo.io/themes/https://gohugo.io/getting-started/quick-start/hugo-theme-cleanwhite/)

[Betrieb unter hostsharing](https://www.hasecke.eu/post/hugo-workflow-hostsharing/)


[Dokumentation](https://gohugo.io/getting-started/usage/)


# DSGVO

https://www.wbs.legal/it-und-internet-recht/datenschutzrecht/datenschutzerklaerung/datenschutzgenerator/


# Vorlagen

* https://www.sulminger-dorffest.de/


# Snippets

hugo new content termine/010.md

hugo server

[Thumbnail Images on your Hugo Blog Posts](https://makewithhugo.com/thumbnail-images-on-your-hugo-blog-posts/)


# Navigation anpassen

Das Theme-Template für die Navigation wurde nach `layouts/partials/nav.html` überschrieben. Dort können Menüpunkte ein-/ausgeblendet werden:

- **Termine-Link**: In `layouts/partials/nav.html` ist der "Termine"-Menüpunkt per Hugo-Kommentar ausgeblendet. Zum Reaktivieren den Kommentar (`{{/* ... */}}`) um den `<li>`-Block entfernen.
- **Weitere Menüpunkte**: Werden über `params.addtional_menus` in `hugo.toml` gesteuert.

## Seiten aus der Sitemap ausblenden

Seiten, die erreichbar bleiben aber nicht von Google indexiert werden sollen, erhalten im Frontmatter:

```yaml
build:
  list: never
```

Damit wird die Seite weiterhin gerendert, erscheint aber nicht in der Sitemap und nicht in Auflistungen.

# Testen

	hugo server --bind 0.0.0.0 --baseURL http://172.30.2.191:1313 --disableFastRender --logLevel debug --enableGitInfo --gc

