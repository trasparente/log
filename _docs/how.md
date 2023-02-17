---
categories: Loglan
class: compact
api_widgets:
  - widgets/github_link.html
  - widgets/github_url.html
  - widgets/image.html
  - widgets/login.html
  - page/favicon.html
api_scripts:
  - scripts/table.coffee
  - scripts/time.coffee
  - scripts/cookie.coffee
  - scripts/details.coffee
  - scripts/update.coffee
---

How
===
{:.no_toc}
- toc
{:toc}

Widgets
-------

{% include widgets/forms/schema.html file='practices'%}

{% include widgets/api.html %}
{% for a in page.api_widgets %}{% include widgets/api.html include=a %}
{% endfor %}

Scripts
-------

{% for a in page.api_scripts %}{% include widgets/api.html include=a %}
{% endfor %}

Kramdown
--------

### Colors and Shades

{% assign colors = 'red,orange,yellow,forest,green,cyan,blue,violet,fucsia' | split: ',' %}
{% assign shades = 'secondary,faint,subtle,liminal,default' | split: ',' %}
{% assign sub_shades = 'faint,subtle,liminal' | split: ',' %}
<div class="flex flex-wrap">
  <ul class="mz list-style-none">
    {% for s in shades %}<li class="{{ s }}-fg spacing-minimal">.{{ s }}-fg</li>{% endfor %}
    <li class="blink spacing-minimal">.blink</li>
  </ul>
  <ul class="mz list-style-none">
    {% for s in shades %}<li class="{{ s }}-bg spacing-minimal">.{{ s }}-bg</li>{% endfor %}
  </ul>
  <ul class="mz list-style-none">
    {% for c in colors %}<li class="{{ c }}-fg spacing-minimal">.{{ c }}-fg</li>{% endfor %}
  </ul>
  <ul class="mz list-style-none">
    {% for c in colors %}<li class="{{ c }}-bg spacing-minimal">.{{ c }}-bg</li>{% endfor %}
  </ul>
  <ul class="mz list-style-none">
    {% for c in colors %}<li class="{{ c }}-subtle-bg spacing-minimal">.{{ c }}-subtle-bg</li>{% endfor %}
  </ul>
</div>

### Inline elements

```html
**Bold** *Italic* <del>Del</del> <ins>Ins</ins> Sup<sup>sup</sup> Sub<sub>sub</sub>
<mark>Mark</mark> <s>Strikethrough</s> <abbr title="Multi&#13;Line">Abbr[title]</abbr>
<cite cite='citation'>Cite[cite]</cite> <q cite="citation">Quote[cite]</q>
Footnotes[^footnote-name]
```

**Bold** *Italic* <del>Del</del> <ins>Ins</ins> Sup<sup>sup</sup> Sub<sub>sub</sub> <mark>Mark</mark> <s>Strikethrough</s>  
<abbr title="Multi&#13;Line">Abbr[title]</abbr> <cite cite='citation'>Cite[cite]</cite> <q cite="citation">Quote[cite]</q> Footnotes[^footnote-name]

[^footnote-name]: If note is not present, `[^footnote-name]` is renderd.

### Code blocks

- Fenced: <code class='secondary-fg'>```lang ... ```</code>
- Liquid: `{% raw %}{%- highlight lang -%}{% endraw %} ... {% raw %}{%- endhighlight -%}{% endraw %}`{:.language-liquid}
- Kramdown: `~~~ lang ... ~~~`
- Indented: 4 spaces, end with `{:.language-lang}`

### Forms

{% assign input = 'text,date,number,color,email,range' | split: ',' %}
<form class='prevent'>
  {% for i in input %}<label>{{ i | capitalize }}:<input required type="{{ i }}" name="{{ i }}" id="{{ i }}">{% if i == 'range' %}<output></output>{% endif %}<span>Description for {{ i }}</span></label>
  {% endfor %}
  <label>Select: <select><option hidden disabled selected value></option>{% for i in input %}<option value="{{ i }}">{{ i }}</option>{% endfor %}</select></label>
  {% include widgets/forms/buttons.html %}
</form>