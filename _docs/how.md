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

{% assign colors = 'blue,green,pink,red,purple,coral' | split: ',' %}
{% assign shades = '0' | split: ',' %}
<div class="flex flex-wrap">
  <ul class="list-style--none">
    <li class="blink">.blink</li>
    {% for c in colors %}<li class="color--{{ c }}-0">.color--{{c}}-0</li>{% endfor %}
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

- Fenced: <code>```lang ... ```</code>
- Tilded: `~~~ lang ... ~~~`
- Indented: 4 spaces `code`, end with `{:.language-lang}`
- Liquid: `{% raw %}{%- highlight lang -%}{% endraw %} ... {% raw %}{%- endhighlight -%}{% endraw %}`{:.language-liquid}


### Forms

{% assign input = 'text,date,number,color,email,range' | split: ',' %}
<form class='prevent'>
  {% for i in input %}<label>{{ i | capitalize }}:<input required type="{{ i }}" name="{{ i }}" id="{{ i }}">{% if i == 'range' %}<output></output>{% endif %}<span>Description for {{ i }}</span></label>
  {% endfor %}
  <label>Select: <select><option hidden disabled selected value></option>{% for i in input %}<option value="{{ i }}">{{ i }}</option>{% endfor %}</select></label>
  {% include widgets/forms/buttons.html %}
</form>