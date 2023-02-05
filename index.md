---
date: 1
---

Home
====

- add `suggestions.html` for posts tagged ... and categorized ... or by author ...
- remove dates in metadata and archive if collection isnt posts and date is `site.time`
- Write page in assets
- link to add data item
- better bars
- implement multiple filters in archive

Forms
-----

{% assign input = 'text,date,number,color,email,range' | split: ',' %}
<form class='prevent'>
  {% for i in input %}<label>{{ i | capitalize }}:<input required type="{{ i }}" name="{{ i }}" id="{{ i }}">{% if i == 'range' %}<output></output>{% endif %}<span>Description for {{ i }}</span></label>
  {% endfor %}
  <label>Select: <select><option hidden disabled selected value></option>{% for i in input %}<option value="{{ i }}">{{ i }}</option>{% endfor %}</select></label>
  <input type="submit" value="Save">
  <input type="reset" value="Reset">
  <input type="button" value="Button">
</form>