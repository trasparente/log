---
tags: [how, now]
categories: [Sugar, Kane]
---

How
===

{% include widgets/api.html include='scripts/table.coffee' %}

## Colors and Shades

{% assign colors = 'blue,red,orange,yellow,green,fucsia,cyan' | split: ',' %}
{% assign shades = 'secondary,faint,subtle,liminal,default' | split: ',' %}
{% assign sub_shades = 'faint,subtle,liminal' | split: ',' %}
<div class="flex">
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

{% include widgets/api.html include='scripts/time.coffee' %}

## Inline

**Bold** *Italic* <del>~~Del</del> <ins>Ins</ins> Sup<sup>qui</sup> Sub<sub>qui</sub> <mark>Mark</mark> <s>Strikethrough</s>  
<abbr title="Multi&#13;Line">Abbr[title]</abbr> <cite cite='citation'>Cite[cite]</cite> <q cite="citation">Quote[cite]</q> Footnotes[^footnote-name]

[^footnote-name]: If note is not present, `[^footnote-name]` is renderd.

> Blockquote: As human beings we are fake entities with fake freedom.
{:.red}

> Blockquote: As human beings we are fake entities with fake freedom.
{:cite="https://example.com"}

<details open>
  <summary>Open</summary>
  As human beings we are fake entities with fake freedom.
</details>

Term is the first line
: Definitions are the successive `: `{:.subtle-bg}&nbsp;lines
: Second

Other
: Again