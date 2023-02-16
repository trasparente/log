---
permalink: archive/
---

# Archive

{% assign tags = '' | split: '' %}
{% assign cats = '' | split: '' %}
{% assign authors = '' | split: '' %}
{% assign all = '' | split: '' %}
{%- for p in site.html_pages %}
  {% assign all = all | push: p %}
  {% for c in p.categories %}{%- assign cats = cats | push: c | uniq -%}{% endfor %}
  {% for t in p.tags %}{%- assign tags = tags | push: t | uniq -%}{% endfor %}
  {% for a in p.authors %}{%- assign authors = authors | push: a | uniq -%}{% endfor %}
{%- endfor -%}
{%- for col in site.collections %}{%- for d in col.docs -%}
  {% assign all = all | push: d %}
  {% for c in d.categories %}{%- assign cats = cats | push: c | uniq -%}{% endfor %}
  {% for t in d.tags %}{%- assign tags = tags | push: t | uniq -%}{% endfor %}
  {% for a in d.authors %}{%- assign authors = authors | push: d | uniq -%}{% endfor %}
{%- endfor -%}{%- endfor -%}

{% assign authors_group = all | where_exp: 'item', 'item.author != nil' | group_by: 'author' %}
{% assign tags_group = all | group_by: 'tags' %}
{% assign cats_group = all | group_by: 'categories' %}
{% assign dates_group = site.posts | group_by_exp: 'item', 'item.date | date_to_string | split: " " | slice: 1, 2 | join: " "' %}

<div class='log margin-box' markdown="1">
Authored: {% for a in authors_group %}<a href='?authored={{ a.name }}' rel='search' title='Search author'>{{ a.name }}</a>{% if a.items.size > 1 %}<sup>{{ a.items.size }}</sup>{% endif %}{% unless forloop.last %},&nbsp;{% endunless %}{% endfor %}

Published: {% for d in dates_group %}<a href='?published={{ d.name }}' rel='search' title='Search date'>{{ d.name }}</a>{% if d.items.size > 1 %}<sup>{{ d.items.size }}</sup>{% endif %}{% unless forloop.last %},&nbsp;{% endunless %}{% endfor %}

Categorized: {% for c in cats %}<a href='?categorized={{ c }}' rel='search' title='Search category'>{{ c }}</a>{% assign cond = 'item.name contains "' | append: c | append: '"' %}{% capture how_many %}{{ cats_group | where_exp: 'item', cond | size }}{% endcapture %}{% assign how_many = how_many | plus: 0 %}{% if how_many > 1 %}<sup>{{ how_many }}</sup>{% endif %}{% unless forloop.last %},&nbsp;{% endunless %}{% endfor %}

Tagged: {% for t in tags %}<a href='?tagged={{ t }}' rel='search' title='Search tag'>{{ t }}</a>{% assign cond = 'item.name contains "' | append: t | append: '"' %}{% capture how_many %}{{ tags_group | where_exp: 'item', cond | size }}{% endcapture %}{% assign how_many = how_many | plus: 0 %}{% if how_many > 1 %}<sup>{{ how_many }}</sup>{% endif %}{% unless forloop.last %},&nbsp;{% endunless %}{% endfor %}

<a href='{{ page.url | absolute_url }}' class='green-fg'>Reset filters</a>
</div>
---
<div>
{% for c in site.collections reversed %}
{% unless c.docs.size == 0 %}
  <div>
  <h3 class='mt1'>{{ c.title | default: c.label | upcase }}</h3>
  <ul>
    <li class='only-visible-child'>Nothing found</li>
  {% for d in c.docs reversed %}<li search-authored="{{ d.author }}" search-categorized='{{ d.categories | join: "," }}' search-tagged='{{ d.tags | join: "," }}' search-published='{{ d.date | date_to_string | split: " " | slice: 1, 2 | join: " " }}'><a href="{{ d.url | absolute_url }}">{{ d.title }}</a></li>{% endfor %}{% endunless %}</ul>
  </div>
{% endfor %}

  <div>
    <h3>PAGES</h3>
    <ul>
      <li class='only-visible-child'>Nothing found</li>
    {% for p in site.html_pages %}
    {% unless p.path contains 'assets/pages/' %}
    <li search-authored="{{ p.author }}" search-categorized='{{ p.categories | join: "," }}' search-tagged='{{ p.tags | join: "," }}' search-published='{{ p.date | date_to_string | split: " " | slice: 1, 2 | join: " " }}'><a href="{{ p.url | absolute_url }}">{{ p.title }}</a></li>{%- endunless %}{% endfor %}
    </ul>
  </div>
</div>

{%- capture api -%}
### Archive

Filter all pages `site.html_pages` and `site.documents`, by date `Mmm YYYY`, author, tags and categories.
{%- endcapture -%}